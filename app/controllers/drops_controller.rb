require 'soundcloud'

class DropsController < ApplicationController
  include ApplicationHelper

  before_action :set_drop, only: [:show, :edit, :update, :destroy]
  before_action :require_creator_of_drop, except: [:index, :show, :new, :create]

  def index
    @drops = Drop.all
  end

  def new
    if session[:access_token_hash].nil?
      render :login_redirect
    else
      @drop = Drop.new
    end
  end

  def edit
  end

  def create
    @place = Place.find_or_create_by(place_params)
    @drop = Drop.new(drop_params.merge({place_id: @place.id, sc_user_id: current_user.id}))
    link_with_track(@drop)

    if @drop.save
      redirect_to drop_path(@drop)
    else
      render :new
    end
  end

  def show
    if @drop.present?
      @place = @drop.place
    end
  end

  def update
    @place = Place.find_or_create_by(place_params)
    if @drop.update_attributes(title: @place.name, place_id: @place.id)
      redirect_to drop_path(@drop), notice: 'Drop successfully updated'
    else
      render :edit, notice: "Oops! That didn't work, please try again."
    end
  end

  def destroy
    if @drop.destroy
      redirect_to root_path, notice: 'Drop successfully deleted'
    end
  end

  def upvote
    @drop = Drop.find(params[:id])
    session[:liked_drops] = [] if session[:liked_drops].nil?

    unless session[:liked_drops].include?(@drop.id)
      @drop.votes.create!
      session[:liked_drops] << @drop.id
    end

    render json: {count_votes: @drop.votes.count, user_session: session[:liked_drops].inspect}
  end

  private

    def set_drop
      @drop = Drop.find(params[:id].to_i)
    end

    def drop_params
      params.require(:drop).permit(:sc_track, :title, :latitude, :longitude, :all_tags)
    end

    def place_params
      params.require(:drop).permit(place: [:name, :longitude, :latitude, :location]).fetch(:place, {})
    end

    def require_creator_of_drop
      page_not_found unless current_user && (@drop.sc_user_id == current_user.id)
    end

    def link_with_track(drop)
      sc_track_id_from_dropdown = params[:drop][:sc_track]
      sc_url_provided = params["sc_url"]

      if sc_track_id_from_dropdown.blank? && sc_url_provided =~ sc_url_regex
        track = resolve_sc_track_id(sc_url_provided)
        drop.assign_attributes(sc_track: track.id, title: track.title)
      else
        drop.assign_attributes(sc_track: sc_track_id_from_dropdown, title: place_params[:name])
      end
      drop
    end

    private

    def sc_url_regex
      /^https?:\/\/(www\.)?soundcloud\.com\/.+\/.+$/i
    end

    def resolve_sc_track_id(sc_url)
       SoundCloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID']).get("/resolve?url=#{sc_url}")
    end
end

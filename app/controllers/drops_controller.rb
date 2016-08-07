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
    link_with_track(@drop)

    if @drop.sc_track.present?
      @drop.update_attributes(place_id: @place.id)
      redirect_to drop_path(@drop), notice: 'Drop successfully updated'
    elsif drop_params["sc_track"].present?
      @drop.update_attributes(drop_params.merge({place_id: @place.id}))
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
      params.require(:drop).permit(:sc_track, :title)
    end

    def place_params
      params.require(:drop).require(:place).permit(:name, :longitude, :latitude, :location)
    end

    def require_creator_of_drop
      page_not_found unless current_user && (@drop.sc_user_id == current_user.id)
    end

    def sc_url
      params["sc_url"]
    end

    def sc_url_regex
      /^https?:\/\/(www\.)?soundcloud\.com\/.+\/.+$/i
    end

    def link_with_track(drop)
      if params[:drop][:sc_track].blank? && sc_url =~ sc_url_regex
        track = SoundCloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID']).get("/resolve?url=#{sc_url}")
        drop.assign_attributes(sc_track: track.id, title: track.title)
      else
        drop.assign_attributes(sc_track: params[:drop][:sc_track], title: place_params[:name])
      end
      drop
    end

end

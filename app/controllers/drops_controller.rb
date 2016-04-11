require 'soundcloud'

class DropsController < ApplicationController

  def index
    @drops = Drop.all
  end

  def new
    if session[:access_token_hash].nil?
      render :login_redirect
    else
      client = SoundCloud.new(:access_token => session[:access_token_hash]["access_token"])
      @current_user = client.get('/me')
      @current_user_tracks = client.get('/me/tracks')
      @drop = Drop.new
    end
  end

  def create
    @place = Place.find_or_create_by(place_params)
    @drop = Drop.new(drop_params.merge({place_id: @place.id}))
    link_with_track(@drop)

    if @drop.save
      redirect_to drop_path(@drop)
    else
      client = SoundCloud.new(:access_token => session[:access_token_hash]["access_token"])
      @current_user = client.get('/me')
      @current_user_tracks = client.get('/me/tracks')
      render :new
    end
  end

  def show
    @drop = Drop.find_by_id(params[:id])
    @drop.present? ? @place = @drop.place : page_not_found
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
    def drop_params
      params.require(:drop).permit(:sc_track, :title)
    end

    def place_params
      params.require(:drop).require(:place).permit(:name, :longitude, :latitude, :location)
    end

    def link_with_track(drop)
      url = params["sc_url"]
      sc_url_regex = /^https?:\/\/(www\.)?soundcloud\.com\/.+\/.+$/i

      if params[:drop][:sc_track].blank? && url =~ sc_url_regex
        client = SoundCloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
        track = client.get("/resolve?url=#{url}")
        drop.sc_track = track.id
        drop.title = track.title
      end
    end
end

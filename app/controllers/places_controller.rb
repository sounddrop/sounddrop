class PlacesController < ApplicationController
  def create
    @place = Place.new(place_params)
    @place.save
    redirect_to places_path
  end

  def index
    @places = Place.all.order('created_at DESC')
  end

  def new 
    # copied from create_controller, needed for happy path when creating new SoundDrop
    # client = Soundcloud.new(:access_token => session[:access_token_hash]["access_token"])
    # @current_user = client.get('/me')
    @places = Place.all.order('created_at DESC')
    @place = Place.new
    # @story = Story.find_by_sc_track(params[:story][:sc_track])
    # redirect_to story_path(@story.sc_track)
  end

  private
  def place_params
    params.require(:place).permit(:name) #name? string? aus schema?
  end
end
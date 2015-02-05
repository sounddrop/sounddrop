class PlacesController < ApplicationController
  def create
    @place = Place.new(place_params)
    @place.save 
    redirect_to places_path
  end

  def index
    @places = Place.all.order('created_at DESC')
  end

  private
  def place_params
    params.require(:place).permit(:name) #name? string? aus schema?
  end
end
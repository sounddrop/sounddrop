class Api::DropsController < ApplicationController
  respond_to :json

  def index
    if params[:longitude] && params[:latitude]
      places_within_radius = Place.near([52.5380655, 13.3939808], 1, :units => :km)
      @drops = Drop.where(place_id: places_within_radius)
      #ids = Ids.all
      #give back drops within radius 1 km: Place.near([40.71, -100.23], 20, :units => :km)
    else
      @drops = Drop.all
    end
  end
end

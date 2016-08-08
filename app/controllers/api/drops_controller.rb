class Api::DropsController < ApplicationController
  respond_to :json

  def index
    if params[:latitude] && params[:longitude]
      places_within_radius = Place.near([params[:latitude], params[:longitude]],  10, units:  :km)
      @drops = Drop.where(place_id: places_within_radius.map(&:id))
    else
      @drops = Drop.all
    end
  end
end


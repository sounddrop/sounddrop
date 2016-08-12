# We use .map instead of .pluck, as .pluck modifies the SELECT clause and produces strange results.

class Api::DropsController < ApplicationController
  DEFAULT_RADIUS = 10
  respond_to :json

  def index
    if params[:latitude] && params[:longitude]
      radius = params[:radius].presence || DEFAULT_RADIUS
      places_within_radius = Place.near([params[:latitude], params[:longitude]], radius, units:  :km)
      @drops = Drop.where(place_id: places_within_radius.map(&:id))
    else
      @drops = Drop.all
    end
  end
end

class Api::DropsController < ApplicationController
  respond_to :json

  def index
    #if params[:longitude]  && params[:latitude]
    #  @drops = Drop.all
      #raise params[:longitude].inspect
      places_within_radius = Place.near(params[:longitude], params[:latitude],  10, units:  :km)
      @drops = Drop.where(place_id: places_within_radius)
      #ids = Ids.all
      #give back drops within radius 1 km: Place.near([40.71, -100.23], 20, :units => :km)
    #end
  end
end
# Long and lat als Float and dann darein packen
# spielen mit dem Radius

class Api::DropsController < ApplicationController
  respond_to :json

  def index
    #if params[:longitude]  && params[:latitude]
    #  @drops = Drop.all
      #raise params[:longitude].inspect
      #puts "Im Controller: #{params.inspect}"
   

      places_within_radius = Place.near([params[:latitude], params[:longitude]],  10, units:  :km)
      
      #puts places_within_radius.inspect
      #puts "----"
      @drops = Drop.where(place_id: places_within_radius.map(&:id))

    #end
  end
end


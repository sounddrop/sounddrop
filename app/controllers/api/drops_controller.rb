class Api::DropsController < ApplicationController
  respond_to :json

  def index
    if params[:longitude] && params[:latitude]
      #give back drops within radius 1 km: Place.near([40.71, -100.23], 20, :units => :km)
    else
      @drops = Drop.all
    end
  end
end

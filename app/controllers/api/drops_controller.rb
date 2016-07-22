class Api::DropsController < ApplicationController
  respond_to :json

  def index
   respond_with Drop.all
  end
end

class Api::DropsController < ApplicationController
  respond_to :json

  def index
    @drops = Drop.all
  end
end

class UserDropsController < ApplicationController
  helper :application

  before_action :require_current_user

  def index
      @drops = Drop.where(sc_user_id: current_user.id)
  end

end

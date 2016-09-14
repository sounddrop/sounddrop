class UserDropsController < ApplicationController
  helper :application

  def index
    if current_user.nil?
      redirect_to login_path
    else
      @drops =  Drop.where("sc_user_id IS :u", u: current_user.id)
    end
  end

end

class UserDropsController < ActionController::Base
  helper :application

  def index
    if current_user.nil?
      redirect_to login_path
    else
    end
  end

end

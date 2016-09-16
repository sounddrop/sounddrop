class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user, :client
  protect_from_forgery with: :exception

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

  def client
    if session[:access_token_hash]
      @client ||= SoundCloud.new(:access_token => session[:access_token_hash]["access_token"])
    end
  end

  def current_user
    @current_user ||= client.get('/me') if client.present?
  end

  def require_current_user
    cookies[:original_url] = request.original_url
    redirect_to login_path unless current_user
  end
end

module ApplicationHelper

  def flash_class(level)
    case level
      when :notice then "info"
      when :error then "error"
      when :alert then "warning"
      when :success then "success"
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

  def current_user_tracks
    @current_user_tracks = client.get('/me/tracks') if current_user
  end

  def current_user_made_drop?(drop)
    !!current_user && (drop.sc_user_id == current_user.id)
  end
end

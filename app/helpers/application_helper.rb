module ApplicationHelper
  def client
    @client ||= SoundCloud.new(:access_token => session[:access_token_hash]["access_token"])
  end

  def current_user
    @current_user ||= client.get('/me') if client.present?
  end

  def current_user_tracks
    @current_user_tracks = client.get('/me/tracks') if client.present?
  end

  def current_user_made_drop?(drop)
    client.present? && (drop.sc_user_id == current_user.id)
  end
end

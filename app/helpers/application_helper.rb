module ApplicationHelper

  def flash_class(level)
    case level
      when :notice then "info"
      when :error then "error"
      when :alert then "warning"
      when :success then "success"
    end
  end

  def current_user_public_tracks
    @current_user_public_tracks = client.get('/me/tracks').select{|t| t.sharing=='public'} if current_user
  end

  def current_user_made_drop?(drop)
    !!current_user && (drop.sc_user_id == current_user.id)
  end
end

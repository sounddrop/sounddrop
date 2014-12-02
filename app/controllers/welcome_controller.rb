require 'soundcloud'

class WelcomeController < ApplicationController
  
  def index
  end	

  def show
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
    @story  = client.get("/tracks/#{params[:id]}")
    @user_id = @story.user_id
    @user_tracks = client.get("/users/#{@user_id.to_s}/tracks/")
    @user_playlists = client.get("/users/#{@user_id.to_s}/playlists/")
  end

end

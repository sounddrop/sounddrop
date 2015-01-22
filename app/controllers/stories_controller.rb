require 'soundcloud'

class StoriesController < ApplicationController
  
  def index
  end	

  def show
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f', 
                            :client_secret => '8ca711ab13836dc62482164d3a952eda',
                            :redirect_uri => 'http://goo.gl/2oUYvd')  
  
    @story  = client.get("/tracks/#{params[:current_track_id]}")
  end

  def playlists
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
    @playlist = client.get("/playlists/#{params[:playlist_id]}") 
    @current_track_id = params[:current_track_id].to_i 
    @story = @playlist.tracks.find do |track|
              track[:id] == params[:current_track_id].to_i
            end
  end

end

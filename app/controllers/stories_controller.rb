require 'soundcloud'

class StoriesController < ApplicationController
  
  def index
  end	

  def show
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f', 
                            :client_secret => '8ca711ab13836dc62482164d3a952eda',
                            :redirect_uri => 'http://goo.gl/2oUYvd')  
  
    begin
      @story  = client.get("/tracks/#{params[:sc_track]}") 
    rescue Soundcloud::ResponseError => e
      puts "Error: #{e.message}, Status Code: #{e.response.code}"
    end
    
    @place = Place.first
    
  end

  def upvote
    @story = Story.find(params[:id])
    @story.votes.create
    redirect_to upvote_story_path(@story.id)
    #@story  = client.post("/stories/#{params[:sc_track]}/upvote")
  end

  def playlists
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
    @playlist = client.get("/playlists/#{params[:playlist_id]}") 
    @place = Place.first
    @current_track_id = params[:sc_track].to_i 
    @story = @playlist.tracks.find do |track|
      track[:id] == params[:sc_track].to_i
    end
  end

end

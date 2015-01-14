require 'soundcloud'

class StoriesController < ApplicationController
  
  def index
  end	

  def show
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f', 
                            :client_secret => '8ca711ab13836dc62482164d3a952eda',
                            :redirect_uri => 'http://goo.gl/2oUYvd')  
  
    # begin
    #   @story  = client.get("/tracks/#{params[:sc_track]}") 
    # rescue Soundcloud::ResponseError => e
    #   puts "Error: #{e.message}, Status Code: #{e.response.code}"
    # end

    @story = Story.find_by_sc_track(params[:sc_track])
    if @story != nil
      @story_at_sc = client.get("/tracks/#{params[:sc_track]}")
    end

    # @place = Place.first
    
  end

  def upvote
    @story = Story.find(params[:id])
    @story.votes.create
    redirect_to :back
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

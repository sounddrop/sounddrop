require 'soundcloud'

class StoriesController < ApplicationController
  
  def index
  end

  def show
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f') 
 
    @story = Story.find_by_sc_track(params[:sc_track])
    if @story != nil
      @story_at_sc = client.get("/tracks/#{params[:sc_track]}")
    end
  end

  def upvote
    @story = Story.find(params[:id])
    if session[:liked_stories].nil?
      session[:liked_stories] = []
    end
    unless 
      session[:liked_stories].include?(@story.id)
    @create_votes = @story.votes.create
      session[:liked_stories] << @story.id
    end
    @count_votes = @story.votes.count
    render json: {count_votes: @count_votes, user_session: session[:liked_stories].inspect}
  end

  def playlists
    @story = Story.find_by_sc_track(params[:sc_track])
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
    @playlist = client.get("/playlists/#{params[:playlist_id]}") 
    @current_track_id = params[:sc_track].to_i 
    @story_at_sc = @playlist.tracks.find do |track|
      track[:id] == params[:sc_track].to_i
    end
  end
end

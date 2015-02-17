require 'soundcloud'
# Rails magically does the requires for you
# require './models/story'
# require './models/vote'

class StoriesController < ApplicationController
  
  def index
  end

  def show
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f') 
    @story = Story.find_by_sc_track(params[:sc_track])
    display_place(@story)
    if @story != nil
      @story_at_sc = client.get("/tracks/#{params[:sc_track]}")
      diplay_image(@story_at_sc)
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
    display_place(@story)
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
    @playlist = client.get("/playlists/#{params[:playlist_id]}") 
    @current_track_id = params[:sc_track].to_i 
    @story_at_sc = @playlist.tracks.find do |track|
      track[:id] == params[:sc_track].to_i
    end
    @playlist.tracks.each do |track|
      begin
        if track.id == @story_at_sc.id 
          diplay_image(@story_at_sc) 
        end
      rescue Exception => e
        e.message
      end
    end
  end

  def diplay_image(story_at_sc)
      @artwork = story_at_sc.artwork_url
      if @artwork == nil
        @artwork = story_at_sc.user.avatar_url
      end 
      @artwork.sub! "large", "crop"
  end  

  def display_place(story)
      unless story.nil?
        unless story.sc_track.nil?
          place = Place.find_by_id(story.place.id)
          if place != nil
           @place_name = place.name
          end
        end 
      end  
  end 

end

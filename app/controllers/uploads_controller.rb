class UploadsController < ApplicationController
  
  require 'soundcloud'

  def login
    client = SoundCloud.new({:client_id => '69e93cf2209402f6f3137a6452cf498f',
                    :client_secret => '8ca711ab13836dc62482164d3a952eda',
                    :redirect_uri => 'http://localhost:3000/verify'})
    
    redirect_to client.authorize_url()
  end

  def verify
    client = SoundCloud.new({:client_id => '69e93cf2209402f6f3137a6452cf498f',
                    :client_secret => '8ca711ab13836dc62482164d3a952eda',
                    :redirect_uri => 'http://localhost:3000/verify'})
    code = params[:code]
    access_token_hash = client.exchange_token(:code => code)
    session[:access_token_hash] = access_token_hash
    # puts "this is the session: " + session[:access_token_hash].to_s
    redirect_to list_tracks_path
  end

  def list_tracks
    # client = Soundcloud.new(:access_token => 'YOUR_ACCESS_TOKEN')
    client = Soundcloud.new(:access_token => session[:access_token_hash]["access_token"])
    @current_user = client.get('/me')
    @current_user_tracks = client.get('/me/tracks')
  end
  
  def upload_track
    user_id = params[:user_id]
    track_id = params[:sc_track]
    track_title = params[:title]
    # place_id = params[:place]

    @story = Story.create(sc_track: params[:sc_track], title: params[:title])

    redirect_to upload_done_path
  end

  def upload
    render json: { }
  
  end

  
end
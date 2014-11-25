require 'soundcloud'
class TracksController < ApplicationController
  def show
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
    @track = client.get("/tracks/#{params[:id]}")
  end
end
require 'soundcloud'
class TracksController < ApplicationController
  def show
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
    @track = client.get("/tracks/#{params[:id]}")

    pic = @track.artwork_url
    if pic.nil?
      pic = @track.user[:avatar_url]    
    end
    @image ="#{pic}".sub("large", "crop")
  end
end
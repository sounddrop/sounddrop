class PlaylistsController < ApplicationController
	def show
		client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
		@playlist = client.get("/playlists/#{params[:id]}")
	end 
end
require 'soundcloud'
class WelcomeController < ApplicationController
  def index
  end
  def show
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
    @track = client.get("/tracks/#{params[178594979]}")
  end
end

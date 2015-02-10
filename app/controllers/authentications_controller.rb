class AuthenticationsController < ApplicationController
  
  require 'soundcloud'

  def signup
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
    # binding.pry
    access_token_data = client.exchange_token(:code => code)
    # puts access_token_data
    session[:access_token_data] = access_token_data
    redirect_to my_stories_path
  end

  def my_stories
    client = Soundcloud.new(:access_token => session[:access_token_data]["access_token"])
    # puts session[:access_token_data]
    @current_user = client.get('/me')

  end

  
end
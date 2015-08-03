class ConnectController < ApplicationController

  require 'soundcloud'

  def login_message
  end

  def login
    client = SoundCloud.new({ client_id: '69e93cf2209402f6f3137a6452cf498f',
                              client_secret: '8ca711ab13836dc62482164d3a952eda',
                              redirect_uri: environment_url })
    redirect_to client.authorize_url()
  end

  def verify
    client = SoundCloud.new({ client_id: '69e93cf2209402f6f3137a6452cf498f',
                              client_secret: '8ca711ab13836dc62482164d3a952eda',
                              redirect_uri: environment_url })
    code = params[:code]
    access_token_hash = client.exchange_token(:code => code)
    session[:access_token_hash] = access_token_hash
    redirect_to new_drop_path
  end

  private

  def environment_url
    Rails.env.production? ? "http://sounddrop.audio/verify" : "http://localhost:3000/verify"
  end
end

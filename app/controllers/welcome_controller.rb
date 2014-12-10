class WelcomeController < ApplicationController

  def index
    @comments = Comment.all.order('created_at DESC')
  end
end
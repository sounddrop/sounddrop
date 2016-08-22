class WelcomeController < ApplicationController

  def index
    @drop = Drop.first
  end

  def about
    
  end
end

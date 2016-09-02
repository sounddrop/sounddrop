class WelcomeController < ApplicationController

  def index
    @drops = Drop.all
  end

  def about

  end
end

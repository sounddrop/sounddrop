class WelcomeController < ApplicationController

  def index
    @drops =  if params[:tag]
                selected_tag.drops
              else
                Drop.all
              end
  end

  def about

  end


    private


  def selected_tag
    Tag.find_by(name: params[:tag].to_s) 
  end
end

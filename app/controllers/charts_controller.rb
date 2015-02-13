 class ChartsController < ApplicationController

 def charts
    date_from = params[:start_date]
    date_to = params[:finish_date]

    if date_from.blank?
      dateF = Date.today-3
      dateT = Date.today
    else
      dateF = Date.parse(date_from) 
      dateT = Date.parse(date_to)
    end

    @categories = (dateF..dateT).map do 
      |date| date.to_s
    end
   
    @stories = Story.all
    @story_votes = @stories.map do |story|
      title = story.title
      # place = Place.find_by_story_id(story.id)
      votes = dateF.upto(dateT).map do |date| 
        story.votes.total_on(date).to_i
      end
      {votes: votes, title: title}  # , place: place.name 
    end

    render json: { categories: @categories, stats: @story_votes }
  end
end
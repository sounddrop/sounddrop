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

    @drops = Drop.all
    @drop_votes = @drops.map do |drop|
      title = drop.title
      # place = Place.find_by_drop_id(drop.id)
      votes = dateF.upto(dateT).map do |date|
        drop.votes.total_on(date).to_i
      end
      {votes: votes, title: title}  # , place: place.name
    end

    render json: { categories: @categories, stats: @drop_votes }
  end
end

namespace :one_time_data_migrations do
  task name_goes_here: :environment do
   
    Place.not_geocoded.each do |place|
      place.location = "Soundcloud HQ, Berlin"
      place.geocode
      place.save
    end

  end
end
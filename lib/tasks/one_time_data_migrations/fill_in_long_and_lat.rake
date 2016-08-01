namespace :one_time_data_migrations do
  task fill_in_long_and_lat: :environment do

    Place.not_geocoded.each do |place|
      place.location = "Soundcloud HQ, Berlin"
      place.geocode
      place.save
    end

  end
end

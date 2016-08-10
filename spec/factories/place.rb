FactoryGirl.define do
  factory :place do
    location 'SoundCloud, Berlin'
    sequence(:name) { |n| "Place #{n}" }
    trait :place_australia do
      location "209 Clarence St, Sydney"
      latitude -33.869717
      longitude 151.205068
    end
      trait :place_near_soundcloud do
        location "U Bernauer Str., Berlin"
        latitude 52.538255
        longitude 13.396255
      end
      trait :place_in_charlottenburg do
        location "Passauer Straße 1, Berlin"
        latitude 52.501623
        longitude 13.340120
      end
  end
end


#drop coordinates actually used when running tests

# "latitude"=>"52.5676612", "longitude"=>"13.2578827"}}
# "latitude"=>"52.5017465", "longitude"=>"13.3399831"

#geolocated coordinates of the adresses

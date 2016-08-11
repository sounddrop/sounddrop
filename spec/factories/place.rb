FactoryGirl.define do
  factory :place do
    location 'SoundCloud, Berlin'
    sequence(:name) { |n| "Place #{n}" }
    trait :place_australia do
      location "209 Clarence St, Sydney"
      latitude -33.869717
      longitude 151.205068
    end
      trait :place_1km_from_soundcloud do
        location "Rheinsbergerstr. 4, Berlin"
      end
      trait :place_in_charlottenburg do
        location "Passauer Straße 1, Berlin"
      end
  end
end


#drop coordinates in tests

# "latitude"=>"52.57542", "longitude"=>"13.28185"}}, => place near soundcloud (Bernauer Str. 81) in test
# "latitude"=>"52.5017465", "longitude"=>"13.3399831" => place in Charlottenburg (same as geocoded)
#"latitude"=>"52.5366012", "longitude"=>"13.3955806" => rheinsberger


# geocoded coordinates:

#geocoded Bernauer Str. 81
# [52.53877, 13.39679]

#geocoded Passauer Str. 1, Berlin
# [52.5017465, 13.3399831] 

#geocoded Rheinsbergerstr. 4
# [52.5366012, 13.3955806] 
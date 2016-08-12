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

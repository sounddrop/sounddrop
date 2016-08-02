FactoryGirl.define do
  factory :place do
    location 'SoundCloud, Berlin'
    sequence(:name) { |n| "Place #{n}" }
    trait :place_australia
      location: "Sydney"
      trait :place_near_soundcloud
        location: "Mauerpark, Berlin"
        trait :place_
          location: ""
    end
  end
end

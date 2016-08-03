FactoryGirl.define do
  factory :place do
    location 'SoundCloud, Berlin'
    sequence(:name) { |n| "Place #{n}" }
    trait :place_australia do
      location "Sydney"
    end
    trait :place_near_soundcloud do
      location "U Bernauer Str., Berlin"
      latitude 52.538255
      longitude 13.396255
    end
  end
end


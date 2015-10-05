FactoryGirl.define do
  factory :place do
    latitude { rand(-90.0..90.0) }
    longitude { rand(-180.0..180.0) }
    sequence(:name) { |n| "Place #{n}" }
  end
end


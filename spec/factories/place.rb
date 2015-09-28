FactoryGirl.define do
  factory :place do
    latitude { rand(-90..90) }
    longitude { rand(-180..180) }
    sequence(:name) { |n| "Place #{n}" }
  end
end


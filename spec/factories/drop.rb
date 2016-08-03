FactoryGirl.define do
  factory :drop do
    sequence(:title) { |n| "Title #{n}"}
    sequence(:sc_track) { |n|  n }
    sequence(:user_id) { |n|  n }
    place # association :place, factory: :place
    trait :drop_at_Bernauer do
      association :place, factory: [:place, :place_near_soundcloud]
    end
  end
end
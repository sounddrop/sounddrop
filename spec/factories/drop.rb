FactoryGirl.define do
  factory :drop do
    sequence(:title) { |n| "Title #{n}"}
    sequence(:sc_track) { |n|  n }
    sequence(:sc_user_id) { |n|  n }
    latitude 53.5
    longitude 13.7


    trait :with_place do
      place # association :place, factory: :place
    end

    trait :drop_in_rheinsberger do
      association :place, factory: [:place, :place_1km_from_soundcloud]
    end

    trait :drop_in_sydney do
      association :place, factory: [:place, :place_australia]
    end

    trait :drop_in_charlottenburg do
      association :place, factory: [:place, :place_in_charlottenburg]
    end
  end
end

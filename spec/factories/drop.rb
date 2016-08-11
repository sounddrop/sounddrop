FactoryGirl.define do
  factory :drop do
    sequence(:title) { |n| "Title #{n}"}
    sequence(:sc_track) { |n|  n }
    sequence(:user_id) { |n|  n }
    place # association :place, factory: :place
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

FactoryGirl.define do
  factory :drop do
    sequence(:title) { |n| "Title #{n}"}
    sequence(:sc_track) { |n|  n }
    sequence(:sc_user_id) { |n|  n }
    place
  end
end

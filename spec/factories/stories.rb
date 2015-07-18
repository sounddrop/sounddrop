# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    sc_track 123456
    title 'Rail Girls meeting'
  end
end
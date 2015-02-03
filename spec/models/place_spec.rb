require 'rails_helper'

RSpec.describe Place, :type => :model do
 it "has multiple stories" do
  place = Place.new
  place.name = "Coffee Machine"
  place.save!

  expect(place.stories).to eq []
 end

it "must have a name" do
  expect {Place.create!}.to raise_error
 end

it 'has multiple stories' do
  place = Place.new
  place.name = "Coffee Machine"
  place.save!
  place = Place.new
  place.name = "Coffee Machine"
  expect {place.save!}.to raise_error
end


end
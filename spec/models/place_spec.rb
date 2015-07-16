require 'rails_helper'

RSpec.describe Place, :type => :model do

 it 'has multiple drops' do
  place = Place.new
  place.name = "Test"
  place.save!
  # same as: Place.create!(name: "Test")
  expect(place.drops).to eq []
 end

  it 'must have a name' do
    expect {Place.create!}.to raise_error
  end

  it 'raises an error when a name is used twice' do
    Place.create!(name: "Test")
    place = Place.new
    place.name = "Test"
    expect {place.save!}.to raise_error
  end
end


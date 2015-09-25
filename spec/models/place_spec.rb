require 'rails_helper'

RSpec.describe Place, :type => :model do

  it 'has multiple drops' do
    place = Place.create!(name: "Test", longitude: 30.00, latitude: 20.00)
    expect(place.drops).to eq []
  end

  it 'must have a name' do
    expect {Place.create!}.to raise_error
  end

  it 'raises an error when a name is used twice' do
    Place.create!(name: "Test", longitude: 30.00, latitude: 20.00)
    place = Place.new
    place.name = "Test"
    expect {place.save!}.to raise_error
  end

  it 'raises an error when numerical of long is invalid' do
    place = Place.new(name: "test", longitude: 180.01, latitude: 20.0)
    expect(place.valid?).to be(false)
    place = Place.new(name: "test" ,longitude: -180.01, latitude: 20.0)
    expect(place.valid?).to be(false)
  end

  it 'raises an error when numerical of latitude is invalid' do
    place = Place.new(name: "test", longitude: 20.5, latitude: 90.01)
    expect(place.valid?).to be(false)
    place = Place.new(name: "test", longitude: 20.5, latitude: -90.01)
    expect(place.valid?).to be(false)
  end


end


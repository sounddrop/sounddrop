require 'rails_helper'

RSpec.describe Place, :type => :model do

  it 'has multiple drops' do
    place = create(:place)
    expect(place.drops).to be_an(Array)
  end

  it 'must have a name' do
    place_test = build(:place, name: nil)
    expect(place_test).not_to be_valid

  end

  it 'raises an error when a name is used twice' do
    place1 = create(:place)
    place2 = build(:place, name: place1.name)
    expect(place2).not_to be_valid
  end
end


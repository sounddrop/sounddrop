require 'rails_helper'

RSpec.describe Place, type: :model do
  let(:place) { create :place, drops: [drop] }
  let(:drop)  { build :drop }

  it 'has multiple drops' do
    expect(place.drops.first).to eql drop
  end

  it 'must have a name' do
    nameless_place = build(:place, name: nil)
    expect(nameless_place).not_to be_valid
  end

  it 'raises an error when a name is used twice' do
    duplicate_place = build(:place, name: place.name)
    expect(duplicate_place).not_to be_valid
  end
end


require 'rails_helper'

RSpec.describe Place do
  let(:place) { create :place }
  let(:drop) { create :drop, place: place }

  describe 'associations' do
    it { is_expected.to have_many :drops }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  it 'has multiple drops' do
    expect(place.reload.drops).to include drop
  end

  describe 'place names must be unique' do
    let!(:place1) { create :place }

    specify do
      expect{ place.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end



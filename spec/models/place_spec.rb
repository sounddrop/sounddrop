require 'rails_helper'

RSpec.describe Place do
  let(:place) { create :place }
  let(:story) { create :story, place: place }

  describe 'associations' do
    it { is_expected.to have_many :stories }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  it 'has multiple stories' do
    expect(place.reload.stories).to include story
  end

  describe 'place names must be unique' do
    let!(:place1) { create :place }

    specify do
      expect{ place.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end



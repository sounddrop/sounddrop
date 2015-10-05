require 'rails_helper'

RSpec.describe Drop, :type => :model do

  it 'must have a SoundCloud track' do
    drop_test = build(:drop, sc_track: nil)
    expect(drop_test).not_to be_valid
  end

  it 'has a place' do
    drop_test = create(:drop, place_id: 1)
    expect(drop_test.place_id).to eql 1
  end

  it 'must have numerical sc_track' do
    drop_test = build(:drop, sc_track: "abc")
    expect(drop_test).not_to be_valid
  end

end

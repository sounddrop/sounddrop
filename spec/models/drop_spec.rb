require 'rails_helper'

RSpec.describe Drop, :type => :model do

  it 'must have a SoundCloud track' do
    expect{Drop.create!}.to raise_error
  end

  it 'has a place' do
    drop_test = Drop.create!(title: "Test", sc_track: "654321", place_id: "1")
    expect(drop_test.place_id).to eql 1
  end

  it 'has only one place' do
    drop_test = Drop.create!(title: "Test", sc_track: "654321", place_id: "1", place_id: "2", place_id: "3")
    expect(drop_test.place_id).to eql 3
  end

  it 'must have numerical sc_track' do
    expect{Drop.create!(title: "Test", sc_track: "abc", place_id: "1")}.to raise_error
  end

end

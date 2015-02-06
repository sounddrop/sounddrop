require 'rails_helper'

RSpec.describe Story, :type => :model do

  it 'must have a SoundCloud track' do
    expect{Story.create!}.to raise_error
  end

  it 'has a place' do
    story_test = Story.create!(title: "Test", sc_track: "654321", place_id: "1")
    expect(story_test.place_id).to eql 1
  end
  
  it 'has only one place' do
    story_test = Story.create!(title: "Test", sc_track: "654321", place_id: "1", place_id: "2", place_id: "3")
    expect(story_test.place_id).to eql 3
  end

  it 'must have unique sc_track' do
    Story.create!(title: "Test1", sc_track: "654321", place_id: "1")
    expect{Story.create!(title: "Test2", sc_track: "654321", place_id: "2")}.to raise_error
  end

  it 'must have numerical sc_track' do
    expect{Story.create!(title: "Test", sc_track: "abc", place_id: "1")}.to raise_error
  end
  
end
require 'spec_helper'
require 'rails_helper'
require 'pry'


describe 'Home page', type: :feature, :vcr => {:cassette_name => "place" }  do
  it 'says welcome' do
    visit "/"
    expect(page).to have_content "Welcome to SoundDrop!"
  end

  it 'has a navigation bar' do
    visit "/"
    expect(page).to have_css("img[src*='/assets/sounddrop-logo-name.png']")
  end
end


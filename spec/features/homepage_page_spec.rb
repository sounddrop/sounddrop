require 'spec_helper'
require 'rails_helper'
require 'pry'


describe 'Home page' , type: :feature do
  it 'says welcome' do
    visit "/"
    expect(page).to have_content "SoundDrop lets you record stories and connect them to a place where they belong - via QR code or geolocation."
  end

  it 'has a navigation bar' do
    visit "/"
    expect(page).to have_css("img[src*='/assets/sounddrop-logo-name.png']")
  end
end


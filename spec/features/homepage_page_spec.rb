require 'rails_helper'

describe 'Home page', type: :feature do
  it 'says welcome' do
    visit "/"
    expect(page).to have_content "Welcome to SoundDrop!"
  end

  it 'has a navigation bar' do
    visit "/"
    expect(page).to have_css("img[src^='/assets/sounddrop-logo-name-']")
  end
end


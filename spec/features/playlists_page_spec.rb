require 'spec_helper'
require 'rails_helper'
require 'pry'


describe "Playlist page" , type: :feature do

  it 'has a navigation bar' do 
    visit "/playlists/74584890/187472038"
    expect(page).to have_css("img[src*='/assets/sounddrop-logo-name.png']")
  end

  # scenario 'klicking on SoundDrop logo links to homepage' do
  #   visit '/playlists/74584890/187472172'
  #   # my_link = find(".sounddrop-image")
  #   click('.sounddrop-image')
  #   expect(page).to have_content("SoundDrop lets you record stories and connect them to a place where they belong - via QR code or geolocation.")
  # end

  it "displays list of stories" do
    visit "/playlists/74584890/187472038"
    expect(find_link("Brewing coffee for engineers")).to be_visible
    expect(find_link("Coffee Machine")).to be_visible
  end

  it "displays story title ", :js => true do 
    visit "/playlists/74584890/187472038"
    within_frame(find("iframe")) do
      expect(page).to have_content("Art Installation")
    end 
  end

  it "displays the place" do
    visit "/playlists/74584890/187472172"
    expect(page).to have_content "@SoundCloud HQ"
  end

  it "has the soundcloud widget" do
    visit "/playlists/74584890/187472172"
    expect(page).to have_selector("iframe")
  end

  it "has a form for comments" do
    visit "/playlists/74584890/187471639"
    expect(page).to have_selector("form")
  end

  it "has a button to save the comments" do
    visit "/playlists/74584890/187471639"
    expect(page).to have_selector("input")
  end

  scenario "writing a comment and sending it saves the comment and shows it on page", js: true do
    visit "/playlists/74584890/187471639"
    fill_in "new_comment", with: "Test comment"
    click_button "Send Comment"
    expect(page).to have_content("Test comment")
  end

  scenario "klicking the like button increases the likes of a story", js: true do
    visit "/playlists/74584890/187472038"
    likes_before = page.find("#votes").text.to_i
    click_button "like"
    likes_now = page.find("#votes").text.to_i
    expect(likes_now - likes_before).to eq(1)
  end
end
require 'spec_helper'
require 'rails_helper'
require 'pry'

describe "Story page" , type: :feature do
  it "displays story title ", :js => true do 
    visit "/stories/187471639"
    within_frame(find("iframe")) do
      expect(page).to have_content("Coffee Machine")
    end 
  end

  it "displays the place" do
    visit "/stories/187471639"
    expect(page).to have_content("@SoundCloud HQ")
  end

  it "has the soundcloud widget" do
    visit "stories/187471639"
    expect(page).to have_selector("iframe")
  end

  it "has a form for comments" do
    visit "stories/187472172"
    expect(page).to have_selector("form")
  end
  
  it "has a button to save the comments" do
    visit "stories/187472172"
    expect(page).to have_selector("input")
  end

  scenario "write a comment and send it", js: true do
    visit "/stories/187472038"
    fill_in "new_comment", with: "Test comment"
    click_button "Send Comment"
    expect(page).to have_content("Test comment")
  end

  scenario "klicking the like button increases the likes of a story", js: true do
    visit "/stories/187472038"
    likes_before = page.find("#votes").text.to_i
    click_button "like"
    likes_now = page.find("#votes").text.to_i
    expect(likes_now - likes_before).to eq(1)
  end
end
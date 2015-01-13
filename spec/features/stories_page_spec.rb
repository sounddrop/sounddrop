require 'spec_helper'
require 'rails_helper'
require 'pry'

describe "Story page" , type: :feature do
  it "displays story title ", :js => true do 
    visit "/stories/180707541"
    within_frame(find("iframe")) do
      expect(page).to have_content("Vinyl Sculpture")
    end 
  end

  it "displays the place" do
    visit "/stories/178594979"
    expect(page).to have_content("@SoundCloud HQ")
  end

  it "has the soundcloud widget" do
    visit "stories/178594490"
    expect(page).to have_selector("iframe")
  end

  it "has a form for comments" do
    visit "stories/178594490"
    expect(page).to have_selector("form")
  end
  
  it "has a button to save the comments" do
    visit "stories/178594490"
    expect(page).to have_selector("input")
  end

  feature "comment", js: true do
    scenario "write a comment and send it" do
      visit "/stories/178594979"
      fill_in "new_comment", with: "Test comment"
      click_button "Send Comment"
      expect(page).to have_content("Test comment")
    end
  end
end
require 'spec_helper'
require 'rails_helper'
require 'pry'

describe "Story page" , type: :feature do
  it "displays story title", :js => true do
    visit "/stories/180707541"
    binding.pry
    expect(page).to have_content("Vinyl Sculpture")
  end

  # it "displays story image" do
  #   visit "/stories/180707541"
  #   expect(page).to have_css("img")
  # end

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
end
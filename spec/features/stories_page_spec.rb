require 'spec_helper'
require 'rails_helper'
require 'pry'


describe "Story page" , type: :feature do
  it "displays story title" do
    visit "/stories/180707541"
    expect(page).to have_content "@SoundCloud HQ"
  end

end

describe "Story page" , type: :feature do
  it "has iframe" do
    visit "/stories/180707541"
    expect(page).to have_css("iframe")
  end

end
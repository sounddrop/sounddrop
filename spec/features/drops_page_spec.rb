require 'spec_helper'
require 'rails_helper'

describe "Drop page" , type: :feature do

  before do
    stub_request(:get, "http://api.soundcloud.com/tracks/187472172").
      with(:query => {
        "client_id" => "69e93cf2209402f6f3137a6452cf498f",
        "format" => "json",
      }).
      to_return(:body => File.read('spec/fixtures/brewing-coffee-for-engineers-1.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"})

    stub_request(:get, "http://api.soundcloud.com/tracks/187471639").
      with(:query => {
        "client_id" => "69e93cf2209402f6f3137a6452cf498f",
        "format" => "json",
      }).
      to_return(:body => File.read('spec/fixtures/coffee-machine-1.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"})

    stub_request(:get, "http://api.soundcloud.com/tracks/187472038").
      with(:query => {
        "client_id" => "69e93cf2209402f6f3137a6452cf498f",
        "format" => "json",
      }).
      to_return(:body => File.read('spec/fixtures/art-installation-1.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"})
  end

  it "displays SoundDrop info" do
    visit "/drops/187471639"
    expect(page).to have_content("@SoundCloud HQ")
    expect(page).to have_content("Ben Kochie shares the history of the coffee machine.")
  end

  # it "has the soundcloud widget" do
  #   visit "drops/187471639"
  #   expect(page).to have_selector("iframe")
  # end

  it "has a form for comments" do
    visit "drops/187472172"
    expect(page).to have_selector("form")
  end

  it "has a button to save the comments" do
    visit "drops/187472172"
    expect(page).to have_selector("input")
  end

  scenario "clicking the like button increases the likes of a drop", js: true do
    visit "/drops/187472038"
    likes_before = page.find("#votes").text.to_i
    click_button "like"
    likes_now = page.find("#votes").text.to_i
    expect(likes_now - likes_before).to eq(1)
  end
end

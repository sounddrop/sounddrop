require 'spec_helper'
require 'rails_helper'

describe "Drop page", type: :feature, :vcr => {:cassette_name => "place" } do
  let!(:drop) { create :drop, sc_track:"187471639", title: "Coffee Machine" }

  before do
    stub_request(:get, "http://api.soundcloud.com/tracks/187471639").
      with(:query => {
        "client_id" => "69e93cf2209402f6f3137a6452cf498f",
        "format" => "json",
      }).
    to_return(:body => File.read('spec/fixtures/coffee-machine-1.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"})
  end

  it "displays SoundDrop info" do
    pending
    visit "/drops/#{drop.id}"
    expect(page).to have_content("@SoundCloud HQ")
    expect(page).to have_content("Ben Kochie shares the history of the coffee machine.")
  end

end

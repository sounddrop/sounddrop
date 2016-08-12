require 'spec_helper'
require 'rails_helper'

describe DropsController, type: :feature, :vcr => {:cassette_name => "place" } do
  let(:place)   { create :place, name: "@SoundCloud HQ" }
  let!(:drop_1) { create :drop, id: 5, sc_track:"187471639", title:"Coffee Machine", place: place }

  before do
    expect_any_instance_of(ApplicationHelper).to receive(:current_user_made_drop?).with(drop_1).and_return false

    stub_request(:get, "http://api.soundcloud.com/tracks/187471639").
      with(:query => {
        "client_id" => "69e93cf2209402f6f3137a6452cf498f",
        "format" => "json",
      }).
    to_return(:body => File.read('spec/fixtures/coffee-machine-1.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"})
  end

  it "displays SoundDrop info" do
    visit "/drops/5"
    expect(page).to have_content("@SoundCloud HQ")
    expect(page).to have_content("Ben Kochie shares the history of the coffee machine.")
  end

end

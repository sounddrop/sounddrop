require 'spec_helper'
require 'rails_helper'

describe "Stats page", type: :feature, :vcr => {:cassette_name => "place" } do

  it "should have a highchart", js: true do
    visit "/stats"
    expect(page).to have_css(".highcharts-container")
  end

end

require 'spec_helper'
require 'rails_helper'
require 'pry'


describe "Stats page" , type: :feature do

  it "should have a highchart", js: true do
    visit "/stats"
    expect(page).to have_css(".highcharts-container")
  end

end

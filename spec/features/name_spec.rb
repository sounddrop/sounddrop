require 'spec_helper'
require 'rails_helper'

describe "Home page" , type: :feature do
   it "says welcome" do
   	   visit "/"
   	   puts page
   	   expect(page).to have_content "Welcome"
   end

end
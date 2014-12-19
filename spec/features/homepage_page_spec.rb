require 'spec_helper'
require 'rails_helper'
require 'pry'


describe "Home page" , type: :feature do
   it "says welcome " do
      visit "/"
      expect(page).to have_content "Welcome"
   end

end

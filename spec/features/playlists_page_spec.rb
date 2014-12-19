require 'spec_helper'
require 'rails_helper'
require 'pry'


describe "Playlist page" , type: :feature do
   it "displays list of stories" do
      visit "/playlists/63171096/180709118"
      expect(find_link("Vinyl Sculpture")).to be_visible
   end

end
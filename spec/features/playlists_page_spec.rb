# require 'spec_helper'
# require 'rails_helper'
# require 'pry'


# describe "Playlist page" , type: :feature do
#    it "displays list of stories" do
#       visit "/playlists/63171096/180709118"
#       expect(find_link("Vinyl Sculpture")).to be_visible
#    end

#      it "displays the place" do
#     visit "/playlists/61140470/178594490"
#     expect(page).to have_content "@SoundCloud HQ"
#   end

#   it "has the soundcloud widget" do
#     visit "/playlists/61140470/178594490"
#     expect(page).to have_selector("iframe")
#   end

#   it "has a form for comments" do
#     visit "/playlists/63171096/180709118"
#     expect(page).to have_selector("form")
#   end
  
#   it "has a button to save the comments" do
#     visit "/playlists/63171096/180709118"
#     expect(page).to have_selector("input")
#   end

# end
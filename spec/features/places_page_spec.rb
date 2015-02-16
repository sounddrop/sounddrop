require 'spec_helper'
require 'rails_helper'
require 'pry'

describe 'Place page', type: :feature do 

  it 'shows all existing places' do
    visit '/places'
    expect(page).to have_content('@SoundCloud HQ')
  end

  it 'creates a place' do
    page.driver.post('/places', {
      :place => {
        :name => 'test_place',
        :admin => true,
      }
    })
    
    expect(page.driver.status_code).to eq(302)

    redirect_to = page.driver.response.headers["Location"]
 
    visit redirect_to

    expect(page).to have_content('test_place')
    # expect(page).to have_content    
  end
  
  # scenario 'filling in a new place creates a new place and shows it', js: true do
  #   visit 'creator page, does not exist yet'
  #   fill_in 'new_place', with: "Test Place"
  #   click_button 'Create Place'
  #   expect(page).to have_content("Test Place")
  # end
end
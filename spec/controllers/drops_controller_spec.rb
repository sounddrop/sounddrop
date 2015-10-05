require 'spec_helper'
require 'rails_helper'
require 'pry'


describe DropsController do

  it "returns 200 if the drop exists" do
     drop = create(:drop)
     get :show , {'id' => drop.sc_track}
     expect(@response.status).to eq(200)
  end
  it "creates a drop at a place" do
    get :create, {
      'sc_url' => 'https://soundcloud.com/prince3eg/prince-3rdeyegirl-the-look-live-in-toronto-05-19-15',
      'drop' => {
        'place' => {
          'name' => "himmel",
          'latitude' => 12.0,
          'longitude' => 12.0
        }
      }
    }
    expect(@response.status).to eq(302)
    place = Drop.last.place
    expect(place.name).to eq("himmel")
    expect(place.latitude).to eq(12.0)
    expect(place.longitude).to eq(12.0)
  end
  it "returns 404 if the drop doesn't exist" do
     get :show , {'id' => '666'}
     expect(@response.status).to eq(404)
  end
end

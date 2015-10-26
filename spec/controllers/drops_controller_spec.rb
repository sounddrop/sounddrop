require 'spec_helper'
require 'rails_helper'
require 'pry'


describe DropsController do

  it "returns 200 if the drop exists" do
    stub_request(:get, "http://api.soundcloud.com/tracks/2").
      with(:query => {
        "client_id" => "69e93cf2209402f6f3137a6452cf498f",
        "format" => "json",
      }).
      to_return(:body => File.read('spec/fixtures/oberholz5.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"})

     drop = create(:drop)
     get :show , {'id' => drop.sc_track}
     expect(@response.status).to eq(200)
  end
  it "creates a drop at a place" do
    url = "http://soundcloud.com/eric/oberholz5"
    stub_request(:get, "http://api.soundcloud.com/resolve").
      with(:query => {
        "client_id" => "69e93cf2209402f6f3137a6452cf498f",
        "format" => "json",
        "url" => url,
      }).
      to_return(:body => File.read('spec/fixtures/oberholz5.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"})

    get :create, {
      'sc_url' => url,
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

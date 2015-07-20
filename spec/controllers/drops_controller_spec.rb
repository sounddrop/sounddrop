require 'spec_helper'
require 'rails_helper'
require 'pry'


describe DropsController do

  it "returns 200 if the drop exists" do
     get :show , {'id' => '187471639'}
     expect(@response.status).to eq(200)
  end
  it "returns 404 if the drop doesn't exist" do
     get :show , {'id' => '666'}
     expect(@response.status).to eq(404)
  end
end

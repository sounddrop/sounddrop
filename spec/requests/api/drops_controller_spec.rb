require 'rails_helper'


RSpec.describe Api::DropsController, :vcr => {:cassette_name => "place" }, type: :request do
  context 'with several drops present' do
  let!(:drops) { FactoryGirl.create_list(:drop, 3) }

    describe "GET /drops" do
              
        it "displays list of  drops in database" do

          get api_drops_path(format: :json)
          expect(response.status).to eq(200)
        end

        it "defines JSON as format in headers" do
          get "/api/drops"
          expect(response.headers["Content-Type"]).to include 'application/json'
        end

        it "delivers valid JSON" do
          get "/api/drops"
          parsed_response = ActiveSupport::JSON.decode(response.body) 
          expect(parsed_response).to be_a Enumerable
        end

        it "contains a place sub-structure" do
          get "/api/drops"
         
          parsed_response = ActiveSupport::JSON.decode(response.body)
          puts parsed_response
          expect(parsed_response[0]["place"]).to include(place: {id: "#{@drops.place.id}", name: "#{@drops.place.name}", latitude: "#{@drops.place.latitude}", longitude: "#{@drops.place.longitude}" })
        end
    end


  end
end



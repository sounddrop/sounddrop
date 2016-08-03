require 'rails_helper'

RSpec.describe Api::DropsController, :vcr, type: :request do
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
        expect(parsed_response[0]["place"].keys).to eq(["id", "name", "latitude", "longitude"])
      end
    end

  #let!(:drops) { FactoryGirl.create_list(:drop, 3) }

    describe "GET /api/drops" do

      context 'with latitude and longitude given' do
        let!(:place) { FactoryGirl.create :place, :place_near_soundcloud }
        let!(:drop) { FactoryGirl.create :drop, :drop_at_Bernauer }

        it "returns the drops that are within a radius of 1 Km" do
          get "/api/drops?lat=52.537016&long=13.394861"
          parsed_response = ActiveSupport::JSON.decode(response.body)
          expect(parsed_response[0].keys).to include("id")
        end



        it "returns empty array if there are no drops within the radius" do

        end
      end
    end
  end

end

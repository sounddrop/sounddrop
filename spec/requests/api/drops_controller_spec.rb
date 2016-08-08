require 'rails_helper'

RSpec.describe Api::DropsController, :vcr, type: :request do
  context 'with several drops present' do
  

    describe "GET /drops" do

      let!(:drops) { FactoryGirl.create_list(:drop, 3) }

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


    describe "GET /api/drops" do

      context 'with latitude and longitude given' do
        let!(:drop_in_berlin) { FactoryGirl.create :drop, :drop_at_Bernauer}
        let!(:drop_in_sydney) { FactoryGirl.create :drop, :drop_in_sydney}

        it "returns drop in Berlin" do
          get "/api/drops?latitude=52.537016&longitude=13.394861" # Somewhere in the middle of Berlin
          parsed_response = ActiveSupport::JSON.decode(response.body)
          expect(parsed_response.length).to eq(1)
          expect(parsed_response[0]["place"].values[2]).to eql drop_in_berlin.place.latitude.to_s
        end



        it "" do

        end
      end
    end
  end

end

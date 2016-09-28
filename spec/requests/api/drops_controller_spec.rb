require 'rails_helper'

RSpec.describe Api::DropsController, :vcr, type: :request do
  context 'with several drops present' do


    describe "GET /drops" do

      let!(:drops_with_place)  { create_list(:drop, 2, :with_place) }
      let!(:drops_in_the_wild) { create_list(:drop, 2) }

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

      context 'with latitude and longitude given' do # will always set the radius to 10km
        let!(:drop_in_berlin) { create :drop, :drop_in_rheinsberger}
        let!(:drop_in_sydney) { create :drop, :drop_in_sydney}

        it "returns drop in Berlin" do
          get "/api/drops?latitude=52.537016&longitude=13.394861" # Somewhere in the middle of Berlin
          parsed_response = ActiveSupport::JSON.decode(response.body)
          expect(parsed_response.length).to eq(1)
          expect(parsed_response[0]["place"].values[2]).to eql drop_in_berlin.place.latitude.to_s
        end

        it "returns an empty array if no drop within radius" do
          get "/api/drops?latitude=4.701647&longitude=-74.041916" # Somewhere in Bogotá
          parsed_response = ActiveSupport::JSON.decode(response.body)
          expect(parsed_response.length).to eq(0)
        end
      end
    end

    context 'with latitude,longitude and radius given' do #
      let!(:drop_in_charlottenburg) { create :drop, :drop_in_charlottenburg}
      let!(:drop_in_rheinsberger) { create :drop, :drop_in_rheinsberger}


      it "returns only drops within given radius" do
        get "/api/drops?latitude=52.537016&longitude=13.394861&radius=0.5" # 1 Km away from SoundCloud
        parsed_response = ActiveSupport::JSON.decode(response.body)
        expect(parsed_response.length).to eq(1)
      end

      it "returns empty array as no drops within radius" do
        get "/api/drops?latitude=4.701647&longitude=-74.041916" # Somewhere in Bogotá
        parsed_response = ActiveSupport::JSON.decode(response.body)
        expect(parsed_response.length).to eq(0)
      end
    end
  end
end

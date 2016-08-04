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
        puts parsed_response
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
        let!(:place_near_soundcloud) { FactoryGirl.create :place, :place_near_soundcloud}
        let!(:place_australia) { FactoryGirl.create :place, :place_australia }
        let!(:drop_at_Bernauer) { FactoryGirl.create :drop, :drop_at_Bernauer}
        let!(:drop_in_sydney) { FactoryGirl.create :drop, :drop_in_sydney}


        it "does not return drops outside of radius" do
          expect(place_near_soundcloud).to be_geocoded
          puts "Near soundcloud:"
          puts place_near_soundcloud.to_coordinates

          puts "Australia"
          expect(place_australia).to be_geocoded
          puts place_australia.to_coordinates

          puts "Drop bernauer"
          expect(drop_at_Bernauer.place).to be_geocoded
          puts drop_at_Bernauer.place.to_coordinates
#
          puts "Drop syndey"
          expect(drop_in_sydney.place).to be_geocoded
          puts drop_in_sydney.place.to_coordinates

          puts "Distance"
          class ANiceClass
            include Geocoder::Calculations
          end
          distance = ANiceClass.new.distance_between(drop_at_Bernauer.place.to_coordinates, place_near_soundcloud.to_coordinates)
          puts distance.to_s


          get "/api/drops?latitude=52.537016&longitude=13.394861"
          parsed_response = ActiveSupport::JSON.decode(response.body)
          #puts parsed_response
          expect(parsed_response[0].keys).to include("id")
        end



        it "returns empty array if there are no drops within the radius" do

        end
      end
    end
  end

end

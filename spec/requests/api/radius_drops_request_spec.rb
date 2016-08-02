require 'rails_helper'

RSpec.describe Api::DropsController, :vcr, type: :request do
  #context 'with lat and long given, with only latitude ' do
  let!(:drops) { FactoryGirl.create_list(:drop, 3) }
    #FactoryGirl.create :place, :place_australia
    describe "GET /api/drops" do
      context 'with latitude and longitude given' do
        it "returns the drops that are within a radius of 1 Km" do
          get  # real data
        end

        it "returns empty array if there are no drops within the radius" do

        end
      end
    end




    end

  end

end

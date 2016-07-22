require 'rails_helper'


RSpec.describe Api::DropsController, :vcr => {:cassette_name => "place" }, type: :request do
  context 'with several drops present' do
  let!(:drops) { FactoryGirl.create_list(:drop, 3) }

    describe "GET /drops" do
        it "displays list of  drops in database" do

          get api_drops_path(format: :json)
          expect(response.status).to eq(200)
        end

        it "renders JSON by default" do
          get "/api/drops"
          expected = ActiveSupport::JSON.decode(drops.to_json)
          parsed_response = ActiveSupport::JSON.decode(response.body)
          expect(parsed_response).to eql expected
        end
    end


  end
end

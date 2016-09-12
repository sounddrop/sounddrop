require 'spec_helper'
require 'rails_helper'

describe WelcomeController do 
  context 'with several drops present' do

    describe "GET /" do

      let!(:drops_with_place)  { create_list(:drop, 2, :with_place) } #with tag


      it "displays only drops with selected tag" do
        get welcome_path
        expect(response.status).to eq(200)
      end
    end

  end
  
end
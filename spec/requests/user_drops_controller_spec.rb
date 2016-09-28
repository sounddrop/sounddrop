require 'rails_helper'

describe UserDropsController, type: :request do

  context 'with logged in user that has created some drops' do

    let(:drop) { build(:drop) }

    let(:dummy_soundcloud_user) do
      double(id: rand(1000), username: nil)
    end

    before do
      allow_any_instance_of(ApplicationHelper).to receive(:current_user).and_return(dummy_soundcloud_user)
    end

    describe "GET  /my_drops" do

      it "displays list of  drops the user has created" do
        get "/my_drops/"
        expect(response.status).to eq(200)
      end

    end

  end

  context 'with non-logged in user' do

    describe "GET /my_drops" do

      it "redirects user to Login page" do
        get "/my_drops"
        expect(response.status).to eq(302)
      end

    end

  end

end

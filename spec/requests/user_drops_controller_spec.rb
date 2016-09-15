require 'rails_helper'

describe UserDropsController, type: :request do

  context 'with logged in user that has created some drops' do

    let(:drop) { build(:drop) }
    
    let(:dummy_user_class) do
      Struct.new(:id)
    end

    let(:dummy_soundcloud_user) do
      dummy_user_class.new(rand(100))
    end

    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(dummy_soundcloud_user)
    end

    describe "GET  users/:id/drops" do

      it "displays list of  drops the user has created" do
        get "/users/#{dummy_soundcloud_user.id}/drops"
        expect(response.status).to eq(200)
      end

    end

  end

  context 'with non-logged in user' do

    non_existing_user_id = 12

    describe "GET  users/:id/drops" do

      it "redirects user to Login page" do
        get "/users/#{non_existing_user_id}/drops"
        expect(response.status).to eq(302)
      end

    end

  end

end

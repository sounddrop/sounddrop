require 'rails_helper'

describe UserDropsController, type: :request do
  context 'with logged in user' do
    let(:dummy_user_class) do
      Struct.new(:id)
    end

    let(:dummy_soundcloud_user) do
      dummy_user_class.new(rand(100))
    end

    before do
      allow(controller).to receive(:current_user).and_return(dummy_soundcloud_user)
    end

    describe "GET  users/:id/drops" do

      it "displays list of  drops the user has created" do
        get "/users/10/drops"

        expect(response.status).to eq(200)
      end

    end

  end


  context 'with non-logged in user' do

    describe "GET  users/:id/drops" do

      it "redirects user to Login page" do
        expect(response.status).to eq(301)
      end

    end

  end

end

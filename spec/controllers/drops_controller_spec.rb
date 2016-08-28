require 'spec_helper'
require 'rails_helper'

describe DropsController, :vcr => {:cassette_name => "place" } do

  describe '#show' do
    it "returns 200 if the drop exists" do
      stub_request(:get, "http://api.soundcloud.com/tracks/2").
        with(:query => {
          "client_id" => "69e93cf2209402f6f3137a6452cf498f",
          "format" => "json",
        }).
        to_return(:body => File.read('spec/fixtures/oberholz5.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"})

       drop = create(:drop)
       get :show , {'id' => drop.id}
       expect(@response.status).to eq(200)
    end
  end

  describe '#create' do
    let(:url) { "http://soundcloud.com/eric/oberholz5" }
    let(:current_user) { JSON.parse(File.read('spec/fixtures/eric.json')) }
    before { allow(controller).to receive(:current_user).and_return SoundCloud::HashResponseWrapper.new(current_user) }

    before do
      # stub the track
      stub_request(:get, "http://api.soundcloud.com/resolve").
        with(:query => {
          "client_id" => "69e93cf2209402f6f3137a6452cf498f",
          "format" => "json",
          "url" => url,
        }).
        to_return(:body => File.read('spec/fixtures/oberholz5.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"}
      )
    end

    it 'creates a drop at a place' do
      get :create, {
        'sc_url' => url,
        'drop' => {
          'place' => {
            'name' => "himmel",
            'latitude' => 12.0,
            'longitude' => 12.0,
            'location' => 'soundcloud'
          },
        'user' => SoundCloud::HashResponseWrapper.new(current_user).id
        }
      }

      expect(@response.status).to eq(302)
      place = Drop.last.place
      expect(place.name).to eq("himmel")
      expect(place.latitude).to eq(12.0)
      expect(place.longitude).to eq(12.0)
      expect(place.location).to eq('soundcloud')
      expect(Drop.last.sc_user_id).to eq(123)
    end

    it 'creates a drop without a place' do
      expect {
        get :create, { sc_url: url, drop: { longitude: 52.0, latitude: 13.0 } }
      }.to change { Drop.count }

      drop = Drop.last

      expect(response).to redirect_to drop_path(drop)
      expect(drop.longitude).to eq(52.0)
      expect(drop.latitude).to eq(13.0)
      expect(drop.place).to be_nil
    end
  end

  describe '#update' do
    let(:current_user) { JSON.parse(File.read('spec/fixtures/eric.json')) }
    let(:drop)         { create :drop, id: 1, title: "Such drop, much wow", sc_track: 345, sc_user_id: SoundCloud::HashResponseWrapper.new(current_user).id }

    context 'successfully updating a drop' do
      before do
        allow(controller).to receive(:current_user).and_return SoundCloud::HashResponseWrapper.new(current_user)
        expect(Drop).to receive(:find).with(drop.id).and_return drop
      end

      describe 'it updates the drop' do
        let(:new_place) { create :place, id: 5, name: 'A new place', location: 'Here, Berlin' }
        let(:params)    {{ id: 1, "drop" => {"place" => { "name" => new_place.name, "location" => new_place.location }}}}

        specify do
          put :update, params
          expect(drop.place_id).to eql 5
          expect(drop.place.name).to eql 'A new place'
          expect(drop.place.location).to eql 'Here, Berlin'
          expect(drop.sc_track).to eql 345
          expect(drop.title).to eql 'A new place'
          expect(response).to redirect_to drop_path(drop)
        end
      end
    end

    context 'unsuccessfully updating a drop' do
      let(:drop)   { build_stubbed :drop, id: 2, sc_user_id: 654 }
      let(:params) {{ id: 2, "place" => { "name" => "a sneaky hacker place", "location" => "sneaky hacker location" }}}

      before do
        expect(controller).to receive(:current_user).and_return nil
        expect(Drop).to receive(:find).with(drop.id).and_return drop
      end

      specify do
        put :update, params
        expect(response.status).to eql 404
        expect(drop.place.name).to_not eql 'a sneaky hacker place'
      end
    end
  end

  describe '#destroy' do
    context 'successfully deleting a drop' do
      let(:current_user) { JSON.parse(File.read('spec/fixtures/eric.json')) }
      let(:drop)  { create :drop, id: 2, sc_user_id: SoundCloud::HashResponseWrapper.new(current_user).id }

      before do
        allow(controller).to receive(:current_user).and_return SoundCloud::HashResponseWrapper.new(current_user)
        expect(Drop).to receive(:find).with(drop.id).and_return drop
      end

      it 'redirects to the homepage' do
        delete :destroy, id: drop.id
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to match /success/
      end

      it 'decreases the number of drops' do
        expect { delete :destroy, id: drop.id }.to change{ Drop.count }.by(-1)
      end
    end

    context 'unsuccessfully deleting a drop' do
      let(:drop) { create :drop, id: 2, sc_user_id: 654 }

      before do
        expect(controller).to receive(:current_user).and_return nil
        expect(Drop).to receive(:find).with(drop.id).and_return drop
      end

      it 'does not decreate the number of drops' do
        expect { delete :destroy, id: drop.id }.not_to change{ Drop.count }
      end
    end
  end

end

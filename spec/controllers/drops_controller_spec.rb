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
    let(:current_user) { JSON.parse(File.read('spec/fixtures/eric.json')) }
    before { expect(controller).to receive(:current_user).and_return SoundCloud::HashResponseWrapper.new(current_user) }

    it 'creates a drop at a place' do
      # stub the track
      url = "http://soundcloud.com/eric/oberholz5"
      stub_request(:get, "http://api.soundcloud.com/resolve").
        with(:query => {
          "client_id" => "69e93cf2209402f6f3137a6452cf498f",
          "format" => "json",
          "url" => url,
        }).
        to_return(:body => File.read('spec/fixtures/oberholz5.json'), :headers => {"Content-Type" => "application/json; charset=utf-8"}
      )

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
  end

  describe '#update' do
    let(:current_user) { JSON.parse(File.read('spec/fixtures/eric.json')) }
    let(:drop)         { create :drop, id: 1, sc_user_id: SoundCloud::HashResponseWrapper.new(current_user).id }

    context 'successfully updating a drop' do
      before do
        expect(controller).to receive(:current_user).twice.and_return SoundCloud::HashResponseWrapper.new(current_user)
        expect(Drop).to receive(:find).with(drop.id).and_return drop
      end

      describe 'it updates the drop when a track id is passed in' do
        let(:new_place)    { create :place, id: 5, name: 'A new place', location: 'Here, Berlin' }
        let(:params) {{ id: 1, "drop" => {"sc_track" => "123456", "place" => { "name" => new_place.name, "location" => new_place.location }}}}

        specify do
          put :update, params
          expect(drop.place_id).to eql 5
          expect(drop.place.name).to eql 'A new place'
          expect(drop.place.location).to eql 'Here, Berlin'
          expect(drop.sc_track).to eql 123456
          expect(response).to redirect_to drop_path(drop)
        end
      end

      describe 'it updates the drop when a url is passed in' do
        # we are making a real api call here
        let(:new_place) { create :place, id: 6, name: 'Russian Graveyard in Tegel', location: 'Tegel, Berlin'}
        let(:params) {{ id: 1, "sc_url" => "https://soundcloud.com/maedelswithamicrophone/sounds-russian-orthodox", "drop" => {"sc_track" => "", "place" => { "name" => new_place.name, "location" => new_place.location }}}}

        specify do
          put :update, params
          expect(drop.place_id).to eql 6
          expect(drop.place.name).to eql 'Russian Graveyard in Tegel'
          expect(drop.place.location).to eql 'Tegel, Berlin'
          expect(drop.sc_track).to eql 82069535
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
        expect(controller).to receive(:current_user).twice.and_return SoundCloud::HashResponseWrapper.new(current_user)
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

require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#client' do
    let(:session) { { access_token_hash: { 'access_token' => '123456'} } }

    context 'with session saved' do
      before do
        allow(helper).to receive(:session).and_return session
      end

      specify 'initializes a SoundCloud client' do
        expect(helper.client.class).to eql SoundCloud::Client
        expect(helper.client.access_token).to eql '123456'
      end

      specify 'loads the already initialized SoundCloud client' do
        client = helper.client
        expect(helper.client).to eql client
      end
    end

    context 'with no session' do
      specify 'does not initialize a soundcloud client' do
        expect(helper.client).to be_nil
      end
    end
  end

  describe '#current_user' do
    context 'no client is present' do
      specify { expect(helper.client).to be_nil }
    end

    context 'a client is present' do
      let(:client) { double 'soundcloud client'}
      let(:current_user) { JSON.parse(File.read('spec/fixtures/eric.json')) }

      before do
        allow(helper.client).to receive(:present?).and_return true
        allow(helper).to receive(:client).and_return client
        allow(client).to receive(:get).with('/me').and_return current_user
      end

      specify 'returns the soundcloud user' do
        expect(helper.current_user).to eql current_user
      end
    end
  end

  describe '#current_user_tracks' do
    context 'current_user is not present' do
      specify { expect(helper.current_user_tracks).to be_nil }
    end

    context 'current_user is present' do
      let(:client) { double 'soundcloud client'}
      let(:current_user) { JSON.parse(File.read('spec/fixtures/eric.json')) }
      let(:track)  { JSON.parse(File.read('spec/fixtures/coffee-machine-1.json')) }

      before do
        allow(helper).to receive(:current_user).and_return current_user
        allow(helper).to receive(:client).and_return client
        allow(client).to receive(:get).with('/me/tracks').and_return track
      end

      specify 'returns the track' do
        expect(helper.current_user_tracks).to eql track
      end
    end
  end

  describe '#current_user_made_drop? drop' do
    let(:drop) { build_stubbed :drop, sc_user_id: '123' }

    context 'current_user is not present' do
      specify { expect(helper.current_user_made_drop?(drop)).to eql false }
    end

    context 'current_user is present' do
      let(:current_user) { SoundCloud::HashResponseWrapper.new(JSON.parse(File.read('spec/fixtures/eric.json'))) }

      before do
        allow(helper).to receive(:current_user).and_return current_user
      end

      context 'the user made the drop' do
        specify { expect(helper.current_user_made_drop?(drop)).to be true }
      end

      context 'the user did not make the drop' do
        let(:drop) { build_stubbed :drop, sc_user_id: '999' }

        specify { expect(helper.current_user_made_drop?(drop)).to be false }
      end
    end
  end
end

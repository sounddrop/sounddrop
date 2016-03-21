require 'rails_helper'

RSpec.describe Drop, :vcr => {:cassette_name => "place" } do

  it 'must have a SoundCloud track' do
    drop_test = build(:drop, sc_track: nil)
    expect(drop_test).not_to be_valid
  end

  it 'has a place' do
    drop_test = create(:drop, place_id: 1)
    expect(drop_test.place_id).to eql 1
  end

  it 'must have numerical sc_track' do
    drop_test = build(:drop, sc_track: "abc")
    expect(drop_test).not_to be_valid
  end

  describe '#image_from' do
    #http://www.rubydoc.info/github/soundcloud/soundcloud-ruby/SoundCloud/HashResponseWrapper#initialize-instance_method
    let(:with_url) { SoundCloud::HashResponseWrapper.new(artwork_url: "https://www.artwork-large.jpg") }
    let(:without_url) { SoundCloud::HashResponseWrapper.new(artwork_url: nil, user: user )}
    let(:user) { SoundCloud::HashResponseWrapper.new(avatar_url: "https://www.avatar-large.jpg")}
    let(:drop) { build :drop }

    describe 'with an artwork url' do
      before { expect(drop).to receive(:soundcloud_track).twice.and_return with_url }

      it 'returns the correct artwork url if present' do
        expect(drop.image_from_track).to eql "https://www.artwork-crop.jpg"
      end
    end

    describe 'without an artwork url' do
      before { expect(drop).to receive(:soundcloud_track).twice.and_return without_url }

      it 'returns the user avatar url if no artwork url present' do
        expect(drop.image_from_track).to eql "https://www.avatar-crop.jpg"
      end
    end
  end

end

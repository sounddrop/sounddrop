require 'spec_helper'
require 'rails_helper'

describe WelcomeController do 
  
  context 'with several drops present and tag "sound" selected' do

    describe "GET /" do

      let!(:drop_without_tag) {create :drop}
      let!(:drop_with_tag_sound) {create :drop, :drop_with_tag_sound}
      let!(:drop_with_tag_story) {create :drop, :drop_with_tag_story}

      it "displays only drops with the tag sound" do
        get "/?tag=sound"
        expect(assigns(:drops).count).to eq(1)
      end
    end

  end
  
end
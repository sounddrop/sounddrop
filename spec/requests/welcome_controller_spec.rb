require 'spec_helper'
require 'rails_helper'

describe WelcomeController do 
  
  context 'with several drops present and tag "sound" selected' do

    describe "GET /" do

      let!(:tag_sound) {create :tag, name: "sound"}
      let!(:tag_story) {create :tag, name: "story"}
      let!(:drop_without_tag) {create :drop}
      let!(:drop_with_tag_sound) {create :drop, all_tags: ["sound"]}
      let!(:drop_with_tag_story) {create :drop, all_tags: ["story"]}

      it "displays only drops with the tag sound" do
        get "/?tag=sound"
        expect(assigns(:drops).count).to eq(1)
      end
    end

  end
  
end
require 'spec_helper'
require 'rails_helper'

describe WelcomeController do 
  
  context 'with two drops present and tag "sound" selected' do

    describe "GET /" do

      let!(:tag) {create :tag, name: "sound"}
      let!(:drop_without_tag) {create :drop}
      let!(:drop_with_tag) {create :drop, all_tags: [tag.name]}

      it "displays only drops with selected tag" do
        get "/?tag=sound"
        expect(assigns(:drops).count).to eq(1)
      end
    end

  end
  
end
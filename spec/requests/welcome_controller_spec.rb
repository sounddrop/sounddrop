require 'spec_helper'
require 'rails_helper'

describe WelcomeController do 
  
  context 'with several drops present and tag "sound" selected' do

    describe "GET /" do

      let!(:tag) {create :tag, name: "sound"}
      let!(:drop_without_tag) {create :drop}
      let!(:drop_with_tag) {create :drop, all_tags: [tag.name]}

      it "displays only drops with selected tag" do
        p drop_with_tag.tags
        get "/?tag=sound"
        p @response.body
        @response = @response.to_a
        expect(@response.length).to eq(1)
      end
    end

  end
  
end
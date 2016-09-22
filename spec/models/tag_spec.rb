require 'rails_helper'

RSpec.describe Tag do
 
  describe 'associations' do
    it { is_expected.to have_many(:drops).through(:taggings) }
  end
end

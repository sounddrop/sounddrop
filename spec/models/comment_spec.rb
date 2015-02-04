require 'rails_helper'

RSpec.describe Comment, :type => :model do
  
  it 'must have content' do  
    comment_test = Comment.create!(text: "Test")
    expect{Comment.create!}.to raise_error
  end
end

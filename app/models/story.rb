class Story < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  has_one :user
end

class Story < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :place
end

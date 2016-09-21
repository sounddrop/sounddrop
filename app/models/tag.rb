class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :drops, through: :taggings
end

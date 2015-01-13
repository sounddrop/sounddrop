class Place < ActiveRecord::Base
  has_many :user
  has_many :stories
end

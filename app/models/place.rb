class Place < ActiveRecord::Base
  has_many :users
  has_many :stories
end

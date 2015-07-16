class Place < ActiveRecord::Base
  has_many :users
  has_many :drops
  validates_associated :drops
  validates :name, presence: true, uniqueness: true
end

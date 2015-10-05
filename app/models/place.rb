class Place < ActiveRecord::Base
  has_many :drops
  validates_associated :drops
  validates :name, presence: true, uniqueness: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end

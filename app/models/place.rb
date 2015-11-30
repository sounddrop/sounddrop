class Place < ActiveRecord::Base
  has_many :drops
  validates_associated :drops

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true

  geocoded_by :location
  after_validation :geocode
end

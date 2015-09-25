class Place < ActiveRecord::Base
  has_many :users
  has_many :drops
  validates_associated :drops
  validates :name, presence: true, uniqueness: true
  validates :longitude, presence: true, :numericality => { :greater_than_or_equal => -180, :less_than_or_equal_to => 180 }
  validates :latitude, presence: true, :numericality => { :greater_than_or_equal => -90, :less_than_or_equal_to => 90 }
end


class Place < ActiveRecord::Base
  has_many :stories
  validates_associated :stories
  validates :name, presence: true, uniqueness: true
end

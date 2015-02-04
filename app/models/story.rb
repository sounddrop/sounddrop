require 'date'
require 'active_support/all'

class Story < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :place

  validates :sc_track, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :place_id, presence: true
end

require 'date'
require 'active_support/all'

class Drop < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  belongs_to :place

  validates :sc_track, presence: true, numericality: { only_integer: true, message: "Sorry, this isn't a valid SoundCloud link. Try again!"}
  validates :place_id, presence: { message: "Please pick a place for your drop."}
end

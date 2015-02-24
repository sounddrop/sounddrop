require 'date'
require 'active_support/all'

class Story < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :place

  # validates :sc_track, presence: true, numericality: { only_integer: true }
  validates :sc_track, :uniqueness => {:scope => [:place], message: "This track is already connected to this place" }, presence: true, numericality: { only_integer: true }
  validates :place_id, presence: true
end

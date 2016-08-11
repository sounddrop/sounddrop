class Place < ActiveRecord::Base
  has_many :drops
  validates_associated :drops

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true

  geocoded_by :location
  after_validation :geocode # eigene Methode schreiben, die daf`r sorgt lat and long gegeben werden, wenn es sie noch nicht gibt, oder wenn es neue
  # koordinaten . Damit lat und llong , wenn sie gegebn werden nicht ueberschrieben werden.

#   before_save :my_method_name, if: :method_name
#
#   private
#
#   def my_method_name
#     # fv,v,,vv
#   end
#
end

class Drop < ActiveRecord::Base

  has_many :votes, dependent: :destroy
  belongs_to :place

  has_many :taggings
  has_many :tags, through: :taggings

  validates :sc_track, presence: true,  numericality: { only_integer: true }
  validates :latitude, :longitude, presence: true

  before_validation :copy_lat_and_long_from_place

    def copy_lat_and_long_from_place
      if place
        self.latitude = place.latitude
        self.longitude = place.longitude
      end
    end

  def image_from_track
    if soundcloud_track.artwork_url.nil?
      soundcloud_track.user.avatar_url.sub! 'large', 'crop'
    else
      soundcloud_track.artwork_url.sub! 'large', 'crop'
    end
  end

  def soundcloud_track
    client = SoundCloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
    client.get("/tracks/#{self.sc_track}")
  end

  def place_name
    place.try(:name)
  end

  def place_location
    place.try(:location)
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end

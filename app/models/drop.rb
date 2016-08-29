class Drop < ActiveRecord::Base

  has_many :votes, dependent: :destroy
  belongs_to :place

  validates :sc_track, presence: true,  numericality: { only_integer: true }

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
end

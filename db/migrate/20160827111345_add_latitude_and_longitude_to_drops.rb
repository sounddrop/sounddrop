class AddLatitudeAndLongitudeToDrops < ActiveRecord::Migration

  class Drop < ActiveRecord::Base
    belongs_to :place
  end

  def up
    add_column :drops, :latitude, :float
    add_column :drops, :longitude, :float

    Drop.reset_column_information
    Drop.includes(:place).find_each do |drop|
      drop.update_columns(latitude: drop.place.latitude, longitude: drop.place.longitude)
    end
  end

  def down
    remove_column :drops, :latitude
    remove_column :drops, :longitude
  end
end

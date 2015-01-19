class RemoveScPlaylistFromPlaces < ActiveRecord::Migration
  def change
    remove_column :places, :sc_playlist, :integer
  end
end

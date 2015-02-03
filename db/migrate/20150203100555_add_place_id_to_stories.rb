class AddPlaceIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :place_id, :integer
  end
end

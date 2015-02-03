class RemoveStoryIdFromPlaces < ActiveRecord::Migration
  def change
    remove_column :places, :story_id
  end
end

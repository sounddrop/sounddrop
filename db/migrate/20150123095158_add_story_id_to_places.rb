class AddStoryIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :story_id, :integer
  end
end

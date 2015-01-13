class RemoveStoryIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :story_id, :integer
  end
end

class AddStoryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :story_id, :integer
  end
end

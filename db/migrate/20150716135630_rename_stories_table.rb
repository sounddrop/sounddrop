class RenameStoriesTable < ActiveRecord::Migration
  def change
    rename_table :stories, :drops
  end
end

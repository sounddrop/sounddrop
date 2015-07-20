class RenameVotesColumnStoryid < ActiveRecord::Migration
  def change
    rename_column :votes, :story_id, :drop_id
  end
end

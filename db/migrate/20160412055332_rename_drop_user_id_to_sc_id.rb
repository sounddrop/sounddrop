class RenameDropUserIdToScId < ActiveRecord::Migration
  def change
    rename_column :drops, :user_id, :sc_user_id
  end
end

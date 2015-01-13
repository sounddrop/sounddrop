class AddStoryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users
  end
  create_table :stories do |t|
    t.belongs_to :user, index: true
    t.integer :story_id
    t.timestamps null: false
  end
end

class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.integer :sc_track
      t.integer :user_id

      t.timestamps
    end
  end
end

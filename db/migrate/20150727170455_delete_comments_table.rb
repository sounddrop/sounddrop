class DeleteCommentsTable < ActiveRecord::Migration
  def up
  	drop_table :comments
  end

  def down
    create_table :comments do |t|
       t.text :text

  	   t.timestamps
    end
  end
end


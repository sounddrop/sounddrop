class CreateTags < ActiveRecord::Migration
  class Tag < ActiveRecord::Base
  end

  def up
    create_table :tags do |t|
      t.string :name

      t.timestamps null: false
    end

    ["sound", "story", "tour", "song"].each do |name|
      Tag.create name: name
    end
  end

  def down
    drop_table :tags
  end
end

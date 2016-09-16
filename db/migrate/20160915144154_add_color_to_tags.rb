class AddColorToTags < ActiveRecord::Migration
  def change
    add_column :tags, :color, :string, default: "#f50"
  end
end

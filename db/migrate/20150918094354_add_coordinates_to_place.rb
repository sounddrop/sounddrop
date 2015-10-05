class AddCoordinatesToPlace < ActiveRecord::Migration
  def change
    add_column :places, :longitude, :decimal
    add_column :places, :latitude, :decimal
  end
end

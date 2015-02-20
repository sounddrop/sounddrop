class AddLatAndLongToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :lat, :decimal
    add_column :places, :lng, :decimal
  end
end

class AddUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
    end
  end
end

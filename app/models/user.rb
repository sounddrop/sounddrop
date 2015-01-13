class Users < ActiveRecord::Base
  has_many :stories
  has_many :places

  def up
    change_table :users do |u|
      story_id  :integer
    end
    User.update_all
  end
end
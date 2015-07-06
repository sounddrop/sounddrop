class Users < ActiveRecord::Base
  has_many :stories
  has_many :places
end

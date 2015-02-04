class Comment < ActiveRecord::Base
  validates :text, presence: true
end

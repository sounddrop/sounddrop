class Tagging < ActiveRecord::Base
  belongs_to :drop
  belongs_to :tag
end

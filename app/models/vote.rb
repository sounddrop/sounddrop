class Vote < ActiveRecord::Base
  belongs_to :drop

  def self.total_on(date)
    where("date(created_at) = ?", date).count
  end
end

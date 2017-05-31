class WorkSchedule < ApplicationRecord

  belongs_to :user

  def start_time
    self.start_date.try(:to_date)
  end

end

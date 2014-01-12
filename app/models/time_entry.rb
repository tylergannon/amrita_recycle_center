class TimeEntry < ActiveRecord::Base
  belongs_to :task
  attr_reader :reporting_date
  
  def reporting_date=(d)
    @reporting_date = d.kind_of?(String) ? Date.parse(d) : d
  end
  
  def length
    end_time - start_time
  end
  
  after_initialize do
    self.reporting_date ||= Time.zone.today
  end
  
  before_save do
    unless reporting_date.nil?
      self.start_time = timeify(start_time)
      self.end_time   = timeify(end_time)
    end
  end

  private
  def timeify(time)
    Time.zone.parse reporting_date.strftime("%Y-%m-%d") + time.strftime(" %H:%M")
  end
end

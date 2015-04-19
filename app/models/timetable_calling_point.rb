class TimetableCallingPoint < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :timing_point
  belongs_to :station


  def to_s
    return station.to_s if station
    return timing_point.to_s if timing_point
    return "Unknown"
  end


  def url
    return station.url if station
    return "#"
  end


end

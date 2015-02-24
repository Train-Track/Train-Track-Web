class JourneyLeg < ActiveRecord::Base
  belongs_to :journey
  belongs_to :departure_station, class_name: "Station"
  belongs_to :arrival_station, class_name: "Station"

  def origin
    return departure_station
  end

  def destination
    return arrival_station
  end

end

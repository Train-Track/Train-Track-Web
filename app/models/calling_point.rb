class CallingPoint
  attr_accessor :station, :st, :et, :at

  def initialize xml
    return if xml.nil?
    self.station = Station.find_by crs: xml.css('crs').text
    self.st = xml.css('st').text
    self.et = xml.css('et').text
    self.at = xml.css('at').text
  end

  def to_s
    station.to_s
  end

  def is_cancelled?
    self.et == "Cancelled"
  end

  def time
    return at if !at.empty?
    return et if !et.empty?
  end

  def css station
    return "list-group-item-info" if self.station == station
    return "disabled" if !at.empty?
    return "list-group-item-danger" if is_cancelled?
  end

  def form_url service
    "/journeys/new?journey_leg[departure_station_id]=#{service.station.id}&" +
    "journey_leg[arrival_station_id]=#{station.id}&" +
    "journey_leg[departure_platform]=#{service.platform}&" +
    "journey_leg[arrival_platform]=&" +
    "journey_leg[scheduled_departure]=#{service.std}&" +
    "journey_leg[actual_departure]=#{service.etd}&" +
    "journey_leg[scheduled_arrival]=#{st}&" +
    "journey_leg[actual_arrival]=#{et}&"
  end

end

require 'action_view'
include ActionView::Helpers::DateHelper

class Service
  attr_accessor :id, :rid, :uid, :train_id, :rsid, :sdd, :category, :activities, :service_type, :operator, :station, :platform, :sta, :eta, :ata, :std, :etd, :atd
  attr_accessor :origin, :destination, :calling_points, :cancelled, :cancelled_reason_code, :cancelled_reason, :delayed, :delayed_reason, :delayed_reason_code, :overdue_message

  def initialize
    @calling_points = []
    @activities = []
  end

  def to_s
    string = "#{origin.to_s} to #{destination.to_s}"
    return string
  end

  def description
    if is_cancelled?
      return "Cancelled"
    elsif atd and (atd == std)
      return "Departed On Time"
    elsif atd and (atd < std)
      return "Departed " + distance_of_time_in_words(std, atd, include_seconds: true) + " early"
    elsif atd and (atd > std)
      return "Departed " + distance_of_time_in_words(std, atd, include_seconds: true) + " late"
    elsif ata and ata == sta
      return "Arrived On Time"
    elsif ata and (ata < sta)
      return "Arrived " + distance_of_time_in_words(sta, ata, include_seconds: true) + " early"
    elsif ata and (ata > sta)
      return "Arrived " + distance_of_time_in_words(sta, ata, include_seconds: true) + " late"
    elsif etd == std
      return "On Time"
    elsif etd
      return "Estmated Departure: " + etd.strftime('%H:%M')
    elsif eta == sta
      return "On Time"
    elsif eta
      return "Estimated Arrival: " + eta.strftime('%H:%M')
    elsif no_report
      return "No Report"
    else
      return "&nbsp;"
    end
  end

  def url
    return "/services/" + Rack::Utils.escape(id)
  end

  def departure_url
    return "#{url}?journey_leg[departure_station_id]=#{station.id}&" +
    "journey_leg[departure_platform]=#{platform}&" +
    "journey_leg[scheduled_departure]=#{std}&" +
    "journey_leg[actual_departure]=#{atd}&" +
    "journey_leg[operator_id]=#{operator.id}&"
  end

  def is_delayed?
    delayed
  end

  def is_cancelled?
    cancelled
  end

  def google_map_image
    return nil if self.calling_points.count == 0
    src = "https://maps.googleapis.com/maps/api/staticmap?path=color:0xff0000%7Cweight:7"
    self.calling_points.each do |calling_point|
      src << "%7C#{calling_point.station.lat},#{calling_point.station.lng}" if calling_point.station and calling_point.station.lat
      src << "%7C#{calling_point.tiploc.lat},#{calling_point.tiploc.lng}" if calling_point.tiploc and calling_point.tiploc.lat
    end
    return src << "&size=320x320&sensor=false&key=#{Rails.application.secrets.google_maps_api_key}".html_safe
  end

  def self.get_service id
    if id.start_with? 'TUBE'
      return UndergroundApiHelper.get_service id
    else
      return NationalRailApiHelper.get_service id
    end
  end

end

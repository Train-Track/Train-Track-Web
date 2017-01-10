require 'action_view'
include ActionView::Helpers::DateHelper

class Service
  attr_accessor :id, :rid, :uid, :train_id, :rsid, :category, :activities, :service_type, :operator, :station, :platform, :sta, :eta, :ata, :std, :etd, :atd
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

  def is_delayed?
    delayed
  end

  def is_cancelled?
    cancelled
  end

  def self.get_service id
    if id.start_with? 'TUBE'
      return UndergroundApiHelper.get_service id
    else
      return NationalRailApiHelper.get_service id
    end
  end

end

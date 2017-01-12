require 'action_view'
include ActionView::Helpers::DateHelper

class CallingPoint
  attr_accessor :station, :tiploc, :sta, :eta, :ata, :std, :etd, :atd, :length
  attr_accessor :cancelled, :delayed, :no_report, :pass, :platform, :activities

  def initialize
    @activities = []
  end

  def to_s
    return station.to_s if station
    return tiploc.to_s if tiploc
    return "Unknown"
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
    elsif etd and etd == std
      return "On Time"
    elsif etd
      return "Estmated Departure: " + etd.strftime('%H:%M')
    elsif eta and eta == sta
      return "On Time"
    elsif eta
      return "Estimated Arrival: " + eta.strftime('%H:%M')
    elsif no_report
      return "No Report"
    else
      return "&nbsp;".html_safe
    end
  end

  def is_cancelled?
    cancelled
  end

  def is_delayed?
    delayed
  end

  def is_future?
    if ata or atd
      return false
    elsif no_report
      return false
    else
      return true
    end
  end

end

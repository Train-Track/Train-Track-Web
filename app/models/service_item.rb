class ServiceItem
  attr_reader :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id, :previous_calling_points, :subsequent_calling_points, :line
  attr_writer :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id, :previous_calling_points, :subsequent_calling_points, :line

  def initialize
  end

  def parse xml
    self.origin = Station.find_by crs: xml.css('origin crs').text
    self.destination = Station.find_by crs: xml.css('destination crs').text

    self.sta = convert_time_string_to_datetime xml.css('sta').text
    estimate = xml.css('eta').text
    if estimate == "On time"
      self.eta = self.sta
    elsif estimate.include? ':'
      self.eta = convert_time_string_to_datetime estimate
    else
      self.eta = nil
    end

    self.std = convert_time_string_to_datetime xml.css('std').text
    estimate = xml.css('etd').text
    if estimate == "On time"
      self.etd = self.std
    elsif estimate.include? ':'
      self.etd = convert_time_string_to_datetime estimate
    else
      self.etd = nil
    end

    self.platform = xml.css('platform').text
    self.operator = Operator.find_by code: xml.css('operatorCode').text
    self.service_id = xml.css('serviceID').text
    self.previous_calling_points = []
    self.subsequent_calling_points = []
    if xml.css('previousCallingPoints').children.size > 0
      xml.css('previousCallingPoints').css('callingPoint').each do |calling_point_xml|
        self.previous_calling_points << CallingPoint.new(calling_point_xml)
      end
    end
    if xml.css('subsequentCallingPoints').children.size > 0
      xml.css('subsequentCallingPoints').css('callingPoint').each do |calling_point_xml|
        self.subsequent_calling_points << CallingPoint.new(calling_point_xml)
      end
    end
  end

  def url
    return "/services/" + Rack::Utils.escape(service_id)
  end

  def css
    if etd == "On time" or eta == "On time"
      return "success"
    else
      return "danger"
    end
  end

  protected

  def convert_time_string_to_datetime string
    if string.nil? or string.empty?
      return
    elsif string.include? ':'
      now = DateTime.now
      time = string.split(':')
      # TODO Fix midnight rollovers, if time is in past, add 1 day
      return DateTime.new(now.year, now.month, now.day, time[0].to_i, time[1].to_i) 
    end
  end

end

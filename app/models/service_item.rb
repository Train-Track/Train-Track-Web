class ServiceItem
  attr_reader :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id, :previous_calling_points, :subsequent_calling_points
  attr_writer :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id, :previous_calling_points, :subsequent_calling_points

  def initialize
  end

  def parse xml
    self.origin = Station.find_by crs: xml.css('origin crs').text
    self.destination = Station.find_by crs: xml.css('destination crs').text
    self.sta = xml.css('sta').text
    self.eta = xml.css('eta').text
    self.std = xml.css('std').text
    self.etd = xml.css('etd').text
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

end

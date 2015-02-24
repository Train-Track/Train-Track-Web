class ServiceItem
  attr_reader :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id
  attr_writer :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id


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
  end


  def url
    return "/services/" + Rack::Utils.escape(service_id)
  end


end

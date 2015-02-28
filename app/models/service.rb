class Service
  attr_accessor :id, :service_type, :operator, :station, :platform, :sta, :eta, :ata, :std, :etd, :atd
  attr_accessor :previous_calling_points, :subsequent_calling_points, :is_cancelled, :disruption_reason, :overdue_message

  def initialize service_id
    self.id = service_id
  end

  def to_s
    return "#{origin.st} #{origin.to_s} to #{destination.to_s}"
  end

  def is_cancelled?
    is_cancelled
  end

  def calling_points
    here = CallingPoint.new nil
    here.station = self.station
    if self.std.empty?
      here.st = self.sta
      here.et = self.eta
      here.at = self.ata
    else
      here.st = self.std
      here.et = self.etd
      here.at = self.atd
    end
    if is_cancelled?
      here.et = "Cancelled"
    end
    return [previous_calling_points, [here], subsequent_calling_points].flatten
  end

  def origin
    return calling_points.first
  end

  def destination
    return calling_points.last
  end

  def parse xml
    self.service_type = xml.css('serviceType').text
    self.is_cancelled = !xml.css('isCancelled').empty?
    self.disruption_reason = xml.css('disruptionReason').text
    self.overdue_message = xml.css('overdueMessage').text
    self.station = Station.find_by crs: xml.css('crs').first.text
    self.operator = Operator.find_by code: xml.css('operatorCode').text
    self.platform = xml.css('platfom').text
    self.sta = xml.css('sta').text
    self.eta = xml.css('eta').text
    self.ata = xml.css('ata').text
    self.std = xml.css('std').text
    self.etd = xml.css('etd').text
    self.atd = xml.css('atd').text
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

  def self.get_service service_id
    NationalRailApiHelper.get_service service_id
  end

end

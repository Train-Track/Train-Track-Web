class Service
  attr_reader :id, :service_type, :operator, :station, :sta, :ata, :std, :atd, :previous_calling_points, :subsequent_calling_points
  attr_writer :id, :service_type, :operator, :station, :sta, :ata, :std, :atd, :previous_calling_points, :subsequent_calling_points


  def initialize service_id
    self.id = service_id
  end


  def parse xml
    self.previous_calling_points = []
    self.subsequent_calling_points = []
    self.service_type = xml.css('serviceType').text
    self.operator = Operator.find_by code: xml.css('operatorCode').text
    self.sta = xml.css('sta').text
    self.ata = xml.css('ata').text
    self.std = xml.css('std').text
    self.atd = xml.css('atd').text
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


  class CallingPoint
    attr_reader :station, :st, :et, :at
    attr_writer :station, :st, :et, :at

    def initialize xml
      self.station = Station.find_by crs: xml.css('crs').text
      self.st = xml.css('st').text
      self.et = xml.css('et').text
      self.at = xml.css('at').text
    end

  end


end

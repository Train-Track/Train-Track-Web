class Service
  attr_accessor :id, :service_type, :operator, :station, :platform, :sta, :eta, :ata, :std, :etd, :atd
  attr_accessor :previous_calling_points, :subsequent_calling_points, :is_cancelled, :disruption_reason, :overdue_message


  def initialize service_id
    self.id = service_id
  end


  def uuid
    "#{operator.code}#{origin.st}#{origin.station.crs}"
  end


  def to_s
    "#{origin.st} #{origin.to_s} to #{destination.to_s}"
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


  def self.get_service service_id
    NationalRailApiHelper.get_service service_id
  end


end

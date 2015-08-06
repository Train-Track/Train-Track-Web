class ServiceItem
  attr_reader :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id, :previous_calling_points, :subsequent_calling_points, :line
  attr_writer :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id, :previous_calling_points, :subsequent_calling_points, :line


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

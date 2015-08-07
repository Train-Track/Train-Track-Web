class ServiceItem
  attr_reader :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id, :previous_calling_points, :subsequent_calling_points, :line, :delayed, :cancelled
  attr_writer :origin, :destination, :sta, :eta, :std, :etd, :platform, :operator, :service_id, :previous_calling_points, :subsequent_calling_points, :line, :delayed, :cancelled


  def to_s
    std.strftime('%H:%M') + " " + destination.to_s
  end


  def is_cancelled?
    cancelled
  end


  def is_delayed?
    delayed
  end


  def url
    return "/services/" + Rack::Utils.escape(service_id)
  end


  def css
    if (etd and (etd == std)) or (eta and (eta == sta))
      return "success"
    else
      return "danger"
    end
  end


end

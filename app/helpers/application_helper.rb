module ApplicationHelper

  #distance MySQL
  def distance_sql lat, lng
    return "7912*ASIN(SQRT(POWER(SIN((lat-#{lat})*pi()/180/2),2)+COS(lat*pi()/180)*COS(#{lat}*pi()/180)*POWER(SIN((lng-#{lng})*pi()/180/2),2)))"
  end

  #bootsrap 3 paginator
  def paginate page
    will_paginate page, renderer: BootstrapPagination::Rails, bootstrap: 3
  end

  #glyphicons
  def icon type
    "<span class=\"glyphicon glyphicon-#{type}\" aria-hidden=\"true\"></span>".html_safe
  end

  # Returns HTML time element with correct timestamps and pretty printed time
  def timestamp time, unknown = "Unknown"
    return unknown if time.nil? or time == 0
    time = Time.at(time.to_i)
    if time.future?
      future = "from now"
    else
      future = "ago"
    end
    "<time class=\"ago\" title=\"#{time}\" datetime=\"#{time.xmlschema}\" data-timestamp=\"#{time.to_i}\">#{time_ago_in_words time} #{future}</time>".html_safe
  end

  def data_feeds_link
    "<a href=\"/data-feeds\"><img src=\"/nre.png\" height=\"50\" alt=\"National Rail Enquiries\">".html_safe
  end
end

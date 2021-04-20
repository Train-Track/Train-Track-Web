module ApplicationHelper

  FACILITIES = {
    "FirstClassLounge" => { icon: "star", name: "1st Class Lounge" },
    "SeatedArea" => { icon: "couch", name: "Seating Area" },
    "WaitingRoom" => { icon: "user-clock", name: "Waiting Room" },
    "Trolleys" => { icon: "luggage-cart", name: "Trolleys" },
    "StationBuffet" => { icon: "utensils", name: "Station Buffet" },
    "Toilets" => { icon: "restroom", name: "Toilets" },
    "BabyChange" => { icon: "baby", name: "Baby Changing Facilities" },
    "Showers" => { icon: "shower", name: "Showers" },
    "Telephones" => { icon: "phone-alt", name: "Telephones" },
    "WiFi" => { icon: "wifi", name: "WiFi" },
    "WebKiosk" => { icon: "at", name: "Internet Kiosk" },
    "PostBox" => { icon: "mail-bulk", name: "Post Box" },
    "TouristInformation" => { icon: "info-circle", name: "Tourist Information" },
    "AtmMachine" => { icon: "money-bill-alt", name: "Cash Machine" },
    "BureauDeChange" => { icon: "money-bill-wave", name: "Bureau De Change" },
    "Shops" => { icon: "shopping-basket", name: "Shops" }
  }

  #distance MySQL
  def distance_sql lat, lng
    return "7912*ASIN(SQRT(POWER(SIN((lat-#{lat})*pi()/180/2),2)+COS(lat*pi()/180)*COS(#{lat}*pi()/180)*POWER(SIN((lng-#{lng})*pi()/180/2),2)))"
  end

  #bootstrap 4 paginator
  def paginate page
    will_paginate page, renderer: WillPaginate::ActionView::BootstrapLinkRenderer
  end

  #font awesome
  def icon type
    "<i class=\"fas fa-#{type}\" aria-hidden=\"true\"></i>".html_safe
  end

  #icon and human name representation of station facilities
  def facility name
    if FACILITIES.key?(name)
      return "#{icon(FACILITIES[name][:icon])} #{FACILITIES[name][:name]}".html_safe
    else
      return name
    end
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

  def attribution source
    " - <a href=\"/data-feeds\" title=\"Data Feeds\">#{source}</a>".html_safe unless source.empty?
  end

end

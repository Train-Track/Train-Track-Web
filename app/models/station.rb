class Station < ActiveRecord::Base
  include NationalRailApiHelper
  default_scope { order('name ASC') }
  # Stations source from:
  # http://www.nationalrail.co.uk/static/documents/content/station_codes.csv
  # http://data.tfl.gov.uk/tfl/syndication/feeds/stations-facilities.xml

  def to_s
    name
  end

  def url
    if is_underground? and underground_code
      return "/tube/" + underground_code
    elsif crs
      return "/stations/" + crs
    end
  end

  def get_departure_board
    if is_underground?
      return nil
    else
      return NationalRailApiHelper.get_departure_board crs
    end
  end

  def get_arrival_board
    if is_underground?
      return nil
    else
      return NationalRailApiHelper.get_arrival_board crs
    end
  end

  def favourite? user
    if user
      return user.favourite_stations.include? self
    else
      return false
    end
  end

  def facilities
    json = read_attribute(:facilities)
    return [] if json.nil?
    return JSON.parse(json)
  end

  def is_underground?
    underground
  end

  def self.underground
    where(underground: true)
  end

  def self.update_underground_station_facilities
    xml = Nokogiri::XML(File.open('underground_station_facilities.xml'))
    xml.css('station').each do |station|
      number = station.attr('id').strip
      name = station.css('name').first.text.strip
      address = station.css('address').first.text.strip
      phone = station.css('phone').first.text.strip
      zones = station.css('zones').first.text.strip
      facilities = []
      station.css('facilities').first.children.each do |facility|
        facilities << { facility.attr('name') => facility.text.strip } unless facility.attr('name').nil?
      end
      coords = station.css('coordinates').first.text.split(",")
      lat = coords[1].to_f
      lng = coords[0].to_f
      station_attributes = {
        name: name,
        address: address,
        phone: phone,
        underground: true,
        underground_zones: zones,
        facilities: facilities.to_json,
        lat: lat,
        lng: lng
      }
      station = Station.where(number: number).first_or_create
      Station.update(station.id, station_attributes)
    end
  end

  def tube_lines
    return []
  end

end

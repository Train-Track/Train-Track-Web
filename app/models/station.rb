class Station < ActiveRecord::Base
  include NationalRailApiHelper
  default_scope { order('name ASC') }
  # Stations source from:
  # http://www.nationalrail.co.uk/static/documents/content/station_codes.csv

  def to_s
    name
  end

  def url
     "/stations/" + crs
  end

  def get_departure_board
    return NationalRailApiHelper.get_departure_board crs
  end

  def get_arrival_board
    return NationalRailApiHelper.get_arrival_board crs
  end

  def favourite? user
    if user
      return user.favourite_stations.include? self
    else
      return false
    end
  end

end

class Station < ActiveRecord::Base
  include NationalRailApiHelper
  default_scope { order('name ASC') }

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

end

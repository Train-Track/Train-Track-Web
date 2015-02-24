class Station < ActiveRecord::Base
  include NationalRailApiHelper

  def to_s
    name
  end

  def url
     "/stations/" + crs
  end

  def get_departure_board
    return NationalRailApiHelper.get_departure_board crs
  end

end

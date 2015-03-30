class Station < ActiveRecord::Base
  include NationalRailApiHelper
  attr_accessor :platforms
  default_scope { order('name ASC') }
  validates :uuid, presence: true, uniqueness: true
  before_validation :add_uuid

  # Stations source from:
  # http://www.nationalrail.co.uk/static/documents/content/station_codes.csv
  # http://data.tfl.gov.uk/tfl/syndication/feeds/stations-facilities.xml


  def to_s
    name
  end


  def url
    "/stations/" + uuid
  end


  def get_departure_board
    if national_rail?
      return NationalRailApiHelper.get_departure_board crs
    end
  end


  def get_arrival_board
    if national_rail?
      return NationalRailApiHelper.get_arrival_board crs
    end
  end


  def get_next_trains
    if underground?
      lines = []
      tube_lines.each do |line|
        line.next_trains = UndergroundApiHelper.get_station_prediction line.code, underground_code
        lines << line
      end
      return lines
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


  def underground?
    underground
  end


  def national_rail?
    national_rail
  end


  def self.underground
    where(underground: true)
  end


  def tube_lines
    return []
  end

  protected
  
  def add_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end

end

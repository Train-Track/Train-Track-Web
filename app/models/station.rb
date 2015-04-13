class Station < ActiveRecord::Base
  include NationalRailApiHelper
  attr_accessor :platforms
  default_scope { order('name ASC') }
  validates :uuid, presence: true, uniqueness: true
  before_validation :add_uuid
  belongs_to :operator

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


  def get_tube_board
    if underground?
      station_board = StationBoard.new
      tube_lines.each do |line|
        line.services = UndergroundApiHelper.get_service_items_for_line_at_station(line.code, underground_code)
        station_board.tube_lines << line        
      end
      return station_board
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
    tube_lines = []
    station_tube_lines = Tube::StationTubeLine.where("from_id = ? OR to_id = ?", id, id)
    station_tube_lines.each do |station_tube_line|
      tube_lines << Tube::Line.find(station_tube_line.tube_line_id)
    end
    return tube_lines.uniq
  end


  protected
  
  def add_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end

end

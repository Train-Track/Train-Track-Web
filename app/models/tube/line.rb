class Tube::Line < ActiveRecord::Base
  self.table_name = "tube_lines"
  attr_accessor :status
  has_and_belongs_to_many :tube_stations

  STATUS_URL = "http://cloud.tfl.gov.uk/TrackerNet/LineStatus"


  def self.get_status
    lines = []
    response = RestClient.get STATUS_URL
    puts response.body
    xml = Nokogiri::XML(response.body)
    xml.remove_namespaces!
    xml.css('LineStatus').each do |line_status|
      number = line_status.attr('ID').to_s
      name = line_status.css('Line').attr('Name').text
      line = Tube::Line.where(number: number).first_or_create(name: name)
      line.status = line_status.css('Status').attr('Description').text
      lines << line
    end
    return lines
  end


  def to_s
    name
  end


  def url
    "/tube/lines/#{code}"
  end


  def style
    "background:##{background_colour};color:##{text_colour}"
  end


end

class Tube::Line < ActiveRecord::Base
  include UndergroundApiHelper
  self.table_name = "tube_lines"
  attr_accessor :status, :status_details, :platforms, :services
  validates :uuid, presence: true, uniqueness: true
  before_validation :add_uuid


  def self.get_status
    UndergroundApiHelper.get_status
  end


  def self.get_weekend
    UndergroundApiHelper.get_weekend
  end


  def next_trains
   return UndergroundApiHelper.get_line_prediction code
  end


  def to_s
    name
  end


  def url
    "/tube/lines/#{uuid}"
  end


  def style
    "background:##{background_colour};color:##{text_colour}"
  end


  protected

  def add_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end


end

class Timetable < ActiveRecord::Base
  belongs_to :station
  belongs_to :operator
  has_many :timetable_calling_points
  validates :uuid, presence: true, uniqueness: true
  before_validation :add_uuid


  def to_s
    origin = timetable_calling_points.first
    destination = timetable_calling_points.last
    return origin.public_time_departure + " " + origin.to_s + " to " + destination.to_s
  end


  def as_json(options={})
    super(include: { timetable_calling_points: { include: [:station, :timing_point] } })
  end


  protected
  
  def add_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end


end
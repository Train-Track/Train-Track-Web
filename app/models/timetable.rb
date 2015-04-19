class Timetable < ActiveRecord::Base
  belongs_to :station
  validates :uuid, presence: true, uniqueness: true
  before_validation :add_uuid


  protected
  
  def add_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end


end
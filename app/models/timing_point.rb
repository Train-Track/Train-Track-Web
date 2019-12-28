class TimingPoint < ActiveRecord::Base
  belongs_to :station, optional: true
  default_scope { order('name ASC') }
  validates :uuid, presence: true, uniqueness: true
  before_validation :add_uuid

  def to_s
    name
  end


  protected

  def add_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end

end

class Operator < ActiveRecord::Base
  has_many :ppms
  default_scope { order('name ASC') }
  validates :uuid, presence: true, uniqueness: true
  before_validation :add_uuid

  def ppm
    ppms.first
  end

  def to_s
    name
  end

  def url
     "/operators/" + uuid
  end

  def tweet_url
    "https://twitter.com/intent/tweet?via=traintrackapp&related=traintrackapp&text=@" + twitter
  end

  protected
  
  def add_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end

end

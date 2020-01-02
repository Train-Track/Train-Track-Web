class Badge < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: "users_badges_joins"
  validates :uuid, presence: true, uniqueness: true
  before_validation :add_uuid


  def to_s
    name
  end


  def url
    "/badges/" + uuid
  end


  def image
    "<img title=\"#{name}\" src=\"#{image_url}\" alt=\"#{name}\">".html_safe
  end


  protected

  def add_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end


end

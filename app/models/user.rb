class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, uniqueness: true, format: { with: /\A\w+\z/, message: "only letters, numbers and underscores" }
  validates :uuid, presence: true, uniqueness: true
  has_and_belongs_to_many :badges, join_table: "user_badges"
  has_and_belongs_to_many :stations, join_table: "user_favourite_stations"
  has_many :journeys
  belongs_to :home_station, class_name: "Station", optional: true
  belongs_to :work_station, class_name: "Station", optional: true
  before_validation :add_uuid

  def image_url(size = 30)
    return "https://secure.gravatar.com/avatar/#{Digest::MD5::hexdigest(email.strip.downcase)}.jpg?s=#{size}&d=identicon"
  end

  def to_s
    username
  end

  def url
     "/users/" + uuid
  end

  def points
    badges.sum(:points)
  end
  
  def favourite_stations
    return stations
  end

  def as_json(options={})
    super(include: [:home_station, :work_station, :badges, { journeys: { include: [journey_legs: { include: [:origin, :destination, :operator] } ] } } ], methods: [:points, :image_url, :favourite_stations])
  end

  protected
  
  def add_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end

end

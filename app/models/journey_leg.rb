class JourneyLeg < ActiveRecord::Base
  belongs_to :journey
  belongs_to :departure_station, class_name: "Station"
  belongs_to :arrival_station, class_name: "Station"
  belongs_to :operator
  default_scope { order('created_at ASC') }
  before_validation :add_uuid

  def origin
    return departure_station
  end

  def destination
    return arrival_station
  end

  def to_s
    "#{origin} to #{destination}"
  end

  def url
    "/journeys/#{journey_id}/legs/#{id}"
  end

  def as_json(options={})
    super(include: [:origin, :destination, :operator])
  end

  protected

  def add_uuid
    self.uuid = SecureRandom.uuid
  end

end

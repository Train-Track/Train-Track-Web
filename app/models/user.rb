class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, uniqueness: true, format: { with: /\A\w+\z/, message: "only letters, numbers and underscores" }
  has_and_belongs_to_many :badges, join_table: "users_badges_joins"
  has_many :journeys
 
  def image_url(size = 30)
    return "https://secure.gravatar.com/avatar/#{Digest::MD5::hexdigest(email.strip.downcase)}.jpg?s=#{size}&d=identicon"
  end

  def to_s
    username
  end

  def url
     "/users/" + username
  end

  def points
    badges.sum(:points)
  end

end

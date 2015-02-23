class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, uniqueness: true, format: { with: /\A\w+\z/, message: "only letters, numbers and underscores" }
  validates :email, uniqueness: true

  def image_url(size = 30)
    return "https://secure.gravatar.com/avatar/#{Digest::MD5::hexdigest(email.strip.downcase)}.jpg?s=#{size}&d=identicon"
  end

  def to_s
    username
  end

  def url
     "/users/" + username
  end

end

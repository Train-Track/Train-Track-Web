class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, length: { in: 2..30 }, uniqueness: true, format: { with: /\A\w+\z/, message: "only letters, numbers and underscores" }
  validates :email, uniqueness: true

end

class Badge < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: "users_badges_joins"

  def to_s
    name
  end

end

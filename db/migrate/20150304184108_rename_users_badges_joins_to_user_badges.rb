class RenameUsersBadgesJoinsToUserBadges < ActiveRecord::Migration
  def change
    rename_table :users_badges_joins, :user_badges
  end
end

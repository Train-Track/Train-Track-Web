class RenameUsersBadgesJoinsToUserBadges < ActiveRecord::Migration[4.2]
  def change
    rename_table :users_badges_joins, :user_badges
  end
end

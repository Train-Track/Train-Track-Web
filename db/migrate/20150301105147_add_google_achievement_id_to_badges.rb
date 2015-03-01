class AddGoogleAchievementIdToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :google_achievement_id, :string
  end
end

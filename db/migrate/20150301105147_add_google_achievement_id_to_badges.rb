class AddGoogleAchievementIdToBadges < ActiveRecord::Migration[4.2]
  def change
    add_column :badges, :google_achievement_id, :string
  end
end

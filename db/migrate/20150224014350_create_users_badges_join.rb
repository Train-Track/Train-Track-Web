class CreateUsersBadgesJoin < ActiveRecord::Migration
  def change
    create_table :users_badges_joins do |t|
      t.integer :user_id
      t.integer :badge_id

      t.timestamps null: false
    end
  end
end

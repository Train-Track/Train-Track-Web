class AddUserFavourites < ActiveRecord::Migration
  def change
    create_join_table :users, :stations, table_name: :user_favourite_stations do |t|
      t.index [:user_id, :station_id]
      t.index [:station_id, :user_id]
    end
  end
end

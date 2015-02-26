class AddHomeStationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_station_id, :integer
    add_index :users, :home_station_id
  end
end

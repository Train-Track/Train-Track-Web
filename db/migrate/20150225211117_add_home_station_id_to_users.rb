class AddHomeStationIdToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :home_station_id, :integer
    add_index :users, :home_station_id
  end
end

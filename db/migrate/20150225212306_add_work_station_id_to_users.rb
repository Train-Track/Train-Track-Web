class AddWorkStationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :work_station_id, :integer
    add_index :users, :work_station_id
  end
end

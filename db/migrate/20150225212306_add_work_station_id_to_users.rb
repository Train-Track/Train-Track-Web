class AddWorkStationIdToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :work_station_id, :integer
    add_index :users, :work_station_id
  end
end

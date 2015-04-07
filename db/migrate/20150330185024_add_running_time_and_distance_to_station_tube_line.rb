class AddRunningTimeAndDistanceToStationTubeLine < ActiveRecord::Migration
  def change
    add_column :station_tube_lines, :running_time, :integer
    add_column :station_tube_lines, :distance, :integer
    add_column :station_tube_lines, :from_id, :integer
    add_column :station_tube_lines, :to_id, :integer
    remove_column :station_tube_lines, :tube_station_id
  end
end

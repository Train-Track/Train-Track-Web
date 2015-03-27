class AddFieldsToStations < ActiveRecord::Migration
  def change
    add_column :stations, :number, :string
    add_column :stations, :facilities, :string
    add_column :stations, :phone, :string
    add_column :stations, :address, :string
    add_column :stations, :underground_zones, :string
    add_index :stations, :number
    drop_table :tube_stations
    rename_table :tube_station_lines, :station_tube_lines
    add_column :station_tube_lines, :id, :integer
    add_index :station_tube_lines, :id
  end
end

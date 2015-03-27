class AddUndergroundCodeToStations < ActiveRecord::Migration
  def change
    add_column :stations, :underground_code, :string
  end
end

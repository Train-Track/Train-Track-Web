class AddUndergroundCodeToStations < ActiveRecord::Migration[4.2]
  def change
    add_column :stations, :underground_code, :string
  end
end

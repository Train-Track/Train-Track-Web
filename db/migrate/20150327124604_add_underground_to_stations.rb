class AddUndergroundToStations < ActiveRecord::Migration[4.2]
  def change
    add_column :stations, :underground, :boolean
  end
end

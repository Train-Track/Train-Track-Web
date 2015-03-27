class AddUndergroundToStations < ActiveRecord::Migration
  def change
    add_column :stations, :underground, :boolean
  end
end

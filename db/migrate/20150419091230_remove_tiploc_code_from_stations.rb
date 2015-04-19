class RemoveTiplocCodeFromStations < ActiveRecord::Migration
  def change
    remove_column :stations, :tiploc_code
  end
end

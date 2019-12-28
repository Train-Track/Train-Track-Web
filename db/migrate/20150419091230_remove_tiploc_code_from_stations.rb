class RemoveTiplocCodeFromStations < ActiveRecord::Migration[4.2]
  def change
    remove_column :stations, :tiploc_code
  end
end

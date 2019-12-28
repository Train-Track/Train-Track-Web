class StationFacilitiesLonger < ActiveRecord::Migration[4.2]
  def change
    change_column :stations, :facilities, :text
  end
end

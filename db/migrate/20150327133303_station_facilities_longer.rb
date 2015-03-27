class StationFacilitiesLonger < ActiveRecord::Migration
  def change
    change_column :stations, :facilities, :text
  end
end

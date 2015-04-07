class AddDirectionToStationTubeLine < ActiveRecord::Migration
  def change
    add_column :station_tube_lines, :direction, :string
  end
end

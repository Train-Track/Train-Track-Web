class AddDirectionToStationTubeLine < ActiveRecord::Migration[4.2]
  def change
    add_column :station_tube_lines, :direction, :string
  end
end

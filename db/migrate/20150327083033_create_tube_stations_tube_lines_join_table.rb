class CreateTubeStationsTubeLinesJoinTable < ActiveRecord::Migration[4.2]
  def change
    create_table :tube_station_lines, :id => false do |t|
      t.integer :tube_station_id
      t.integer :tube_line_id
    end
    add_index :tube_station_lines, [:tube_station_id, :tube_line_id]
  end
end

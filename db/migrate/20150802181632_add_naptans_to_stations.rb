class AddNaptansToStations < ActiveRecord::Migration[4.2]
  def change
    add_column :stations, :rail_naptan, :string
    add_column :stations, :underground_naptan, :string
    add_index :stations, :rail_naptan
    add_index :stations, :underground_naptan
  end
end

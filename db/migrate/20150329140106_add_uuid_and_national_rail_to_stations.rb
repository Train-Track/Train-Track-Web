class AddUuidAndNationalRailToStations < ActiveRecord::Migration
  def change
    add_column :stations, :uuid, :string
    add_column :stations, :national_rail, :boolean
    add_index :stations, :uuid, :unique => true
  end
end

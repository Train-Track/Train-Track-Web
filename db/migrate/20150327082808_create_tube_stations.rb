class CreateTubeStations < ActiveRecord::Migration
  def change
    create_table :tube_stations do |t|
      t.string :name
      t.string :code
      t.string :number
      t.text :facilities
      t.text :address
      t.string :phone
      t.string :zones
      t.decimal :lat, :precision => 10, :scale => 7
      t.decimal :lng, :precision => 10, :scale => 7

      t.timestamps null: false
    end
    add_index :tube_stations, [:code, :number]
  end
end

class CreateStations < ActiveRecord::Migration[4.2]
  def change
    create_table :stations do |t|
      t.string :name
      t.string :crs
      t.decimal :lat, :precision => 10, :scale => 7
      t.decimal :lng, :precision => 10, :scale => 7
      t.timestamps null: false
    end
  end
end

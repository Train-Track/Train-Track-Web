class CreateTimingPoints < ActiveRecord::Migration[4.2]
  def change
    create_table :timing_points do |t|
      t.string :name
      t.string :code
      t.string :uuid
      t.integer :station_id
      t.decimal :lat, :precision => 10, :scale => 7
      t.decimal :lng, :precision => 10, :scale => 7
      t.timestamps null: false
    end
    add_index :timing_points, [:code, :uuid, :station_id]
  end
end

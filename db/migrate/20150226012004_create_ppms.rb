class CreatePpms < ActiveRecord::Migration[4.2]
  def change
    create_table :ppms do |t|
      t.references :operator, index: true
      t.integer :ppm
      t.integer :on_time
      t.integer :late
      t.integer :cancel_very_late
      t.integer :total

      t.timestamps null: false
    end
    add_foreign_key :ppms, :operators
  end
end

class CreateTubeLines < ActiveRecord::Migration
  def change
    create_table :tube_lines do |t|
      t.string :name
      t.string :code
      t.string :number
      t.string :background_colour
      t.string :text_colour

      t.timestamps null: false
    end
    add_index :tube_lines, [:code, :number]
  end
end

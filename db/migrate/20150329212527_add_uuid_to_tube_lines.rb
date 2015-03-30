class AddUuidToTubeLines < ActiveRecord::Migration
  def change
    add_column :tube_lines, :uuid, :string
    add_index :tube_lines, :uuid, :unique => true
  end
end

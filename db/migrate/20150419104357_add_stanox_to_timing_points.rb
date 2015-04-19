class AddStanoxToTimingPoints < ActiveRecord::Migration
  def change
    add_column :timing_points, :stanox, :string
    add_index :timing_points, [:stanox]
  end
end

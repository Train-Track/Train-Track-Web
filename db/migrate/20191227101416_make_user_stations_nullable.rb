class MakeUserStationsNullable < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :home_station_id, :integer, null: true
    change_column :users, :work_station_id, :integer, null: true
  end
end

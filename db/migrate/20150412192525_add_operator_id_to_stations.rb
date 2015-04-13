class AddOperatorIdToStations < ActiveRecord::Migration
  def change
    add_column :stations, :operator_id, :integer
    add_column :stations, :tiploc_code, :string
  end
end

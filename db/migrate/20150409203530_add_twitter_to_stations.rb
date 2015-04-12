class AddTwitterToStations < ActiveRecord::Migration
  def change
    add_column :stations, :twitter, :string
  end
end

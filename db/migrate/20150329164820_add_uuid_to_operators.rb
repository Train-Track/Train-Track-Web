class AddUuidToOperators < ActiveRecord::Migration
  def change
    add_column :operators, :uuid, :string
    add_index :operators, :uuid, :unique => true
  end
end

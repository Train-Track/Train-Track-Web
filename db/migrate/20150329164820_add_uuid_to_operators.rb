class AddUuidToOperators < ActiveRecord::Migration[4.2]
  def change
    add_column :operators, :uuid, :string
    add_index :operators, :uuid, :unique => true
  end
end

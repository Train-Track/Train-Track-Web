class AddUuidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uuid, :string
    add_index :users, :uuid, :unique => true
  end
end

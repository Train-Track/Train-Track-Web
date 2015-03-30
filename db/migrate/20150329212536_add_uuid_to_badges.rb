class AddUuidToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :uuid, :string
    add_index :badges, :uuid, :unique => true
  end
end

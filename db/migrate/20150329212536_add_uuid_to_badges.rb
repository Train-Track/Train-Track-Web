class AddUuidToBadges < ActiveRecord::Migration[4.2]
  def change
    add_column :badges, :uuid, :string
    add_index :badges, :uuid, :unique => true
  end
end

class AddUuidToJourneys < ActiveRecord::Migration
  def change
    add_column :journeys, :uuid, :string
    add_index :journeys, :uuid, :unique => true
  end
end

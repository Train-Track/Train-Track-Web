class AddUuidToJourneys < ActiveRecord::Migration[4.2]
  def change
    add_column :journeys, :uuid, :string
    add_index :journeys, :uuid, :unique => true
  end
end

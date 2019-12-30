class AddUuidToJourneyLegs < ActiveRecord::Migration[4.2]
  def change
    add_column :journey_legs, :uuid, :string
    add_index :journey_legs, :uuid, :unique => true
  end
end

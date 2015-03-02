class AddUuidToJourneyLegs < ActiveRecord::Migration
  def change
    add_column :journey_legs, :uuid, :string
    add_index :journey_legs, :uuid, :unique => true
  end
end

class CreateJourneyLegs < ActiveRecord::Migration[4.2]
  def change
    create_table :journey_legs do |t|
      t.references :journey, index: true
      t.integer :departure_station_id, null: false
      t.integer :arrival_station_id, null: false
      t.datetime :scheduled_departure
      t.datetime :scheduled_arrival
      t.datetime :actual_departure
      t.datetime :actual_arrival
      t.string :departure_platform
      t.string :departure_arrival

      t.timestamps null: false
    end
    add_foreign_key :journey_legs, :journeys
  end
end

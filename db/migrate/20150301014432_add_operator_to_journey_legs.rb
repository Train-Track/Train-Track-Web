class AddOperatorToJourneyLegs < ActiveRecord::Migration[4.2]
  def change
    add_column :journey_legs, :operator_id, :integer
    add_foreign_key :journey_legs, :operators
  end
end

class AddOperatorToJourneyLegs < ActiveRecord::Migration
  def change
    add_column :journey_legs, :operator_id, :integer
    add_foreign_key :journey_legs, :operators
  end
end

class RenameJourneyLegsDepartureArrivalToArrivalPlatform < ActiveRecord::Migration[4.2]
  def change
    rename_column :journey_legs, :departure_arrival, :arrival_platform
  end
end
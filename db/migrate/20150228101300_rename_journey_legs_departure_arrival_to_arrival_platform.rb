class RenameJourneyLegsDepartureArrivalToArrivalPlatform < ActiveRecord::Migration
  def change
    rename_column :journey_legs, :departure_arrival, :arrival_platform
  end
end
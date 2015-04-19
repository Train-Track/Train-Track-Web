class ChangeTypeInTimetablestoTrainType < ActiveRecord::Migration
  def change
    rename_column :timetables, :type, :train_type
  end
end

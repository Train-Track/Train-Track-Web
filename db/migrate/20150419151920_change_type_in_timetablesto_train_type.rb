class ChangeTypeInTimetablestoTrainType < ActiveRecord::Migration[4.2]
  def change
    rename_column :timetables, :type, :train_type
  end
end

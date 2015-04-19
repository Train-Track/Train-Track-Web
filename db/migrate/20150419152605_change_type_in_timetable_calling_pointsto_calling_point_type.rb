class ChangeTypeInTimetableCallingPointstoCallingPointType < ActiveRecord::Migration
  def change
    rename_column :timetable_calling_points, :type, :calling_point_type
  end
end

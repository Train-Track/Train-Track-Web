class CreateTimetableCallingPoints < ActiveRecord::Migration[4.2]
  def change
    create_table :timetable_calling_points do |t|
      t.integer :timetable_id
      t.string :type
      t.boolean :cancelled
      t.string :tiploc_code
      t.integer :timing_point_id
      t.integer :station_id
      t.string :public_time_arrival 
      t.string :public_time_departure 
      t.string :working_time_arrival 
      t.string :working_time_departure
      t.string :working_time_passing 
      t.string :platform
      t.text :activities
      t.text :planned_activities
      t.timestamps null: false
    end
    add_index :timetable_calling_points, :station_id
    add_index :timetable_calling_points, :timing_point_id
    add_index :timetable_calling_points, :timetable_id
  end
end

class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.string :rtti_id
      t.string :uuid
      t.integer :operator_id
      t.string :train_id
      t.string :schedule_id
      t.date :start_date
      t.string :type
      t.string :train_category
      t.text :late_running_reason
      t.text :cancellation_reason
      t.timestamps null: false
    end
    add_index :timetables, [:uuid]
  end
end

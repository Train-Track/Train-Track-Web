class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string :code
      t.string :uuid
      t.text :late_running_reason
      t.text :cancellation_reason
      t.timestamps null: false
    end
    add_index :reasons, [:uuid, :code]
  end
end

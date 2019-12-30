class CreateApiCalls < ActiveRecord::Migration[4.2]
  def change
    create_table :api_calls do |t|
      t.string :type
      t.text :url
      t.integer :response_code
      t.text :response
      t.integer :response_time
      t.timestamps null: false
    end
  end
end

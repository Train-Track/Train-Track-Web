class CreateOperators < ActiveRecord::Migration[4.2]
  def change
    create_table :operators do |t|
      t.string :name
      t.string :code
      t.string :twitter
      t.string :delay_repay_url
      t.timestamps null: false
    end
  end
end

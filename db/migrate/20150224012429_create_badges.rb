class CreateBadges < ActiveRecord::Migration[4.2]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :description
      t.string :image_url
      t.integer :points

      t.timestamps null: false
    end
  end
end

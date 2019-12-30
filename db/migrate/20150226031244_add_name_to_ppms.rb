class AddNameToPpms < ActiveRecord::Migration[4.2]
  def change
    add_column :ppms, :name, :string
  end
end

class AddNameToPpms < ActiveRecord::Migration
  def change
    add_column :ppms, :name, :string
  end
end

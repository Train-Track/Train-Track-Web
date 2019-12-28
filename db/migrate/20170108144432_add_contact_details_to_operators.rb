class AddContactDetailsToOperators < ActiveRecord::Migration[4.2]
  def change
    add_column :operators, :phone, :string
    add_column :operators, :website, :string
    add_column :operators, :email, :string
  end
end

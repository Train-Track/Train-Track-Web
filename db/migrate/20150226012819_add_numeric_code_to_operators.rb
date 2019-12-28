class AddNumericCodeToOperators < ActiveRecord::Migration[4.2]
  def change
    add_column :operators, :numeric_code, :string
  end
end

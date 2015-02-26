class AddNumericCodeToOperators < ActiveRecord::Migration
  def change
    add_column :operators, :numeric_code, :string
  end
end

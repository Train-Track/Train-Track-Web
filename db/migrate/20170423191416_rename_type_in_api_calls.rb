class RenameTypeInApiCalls < ActiveRecord::Migration[4.2]
  def change
    rename_column :api_calls, :type, :source
  end
end

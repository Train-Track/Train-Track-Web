class RenameTypeInApiCalls < ActiveRecord::Migration
  def change
    rename_column :api_calls, :type, :source
  end
end

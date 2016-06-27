class ChangeColumnsOfTables < ActiveRecord::Migration
  def change
  	remove_column :events, :public
  	remove_column :images, :photographer_id
  end
end

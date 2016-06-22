class ChangeColumnsTypeClient < ActiveRecord::Migration
  def change
    rename_column :clients, :first_name, :firstname
  	rename_column :clients, :last_name, :lastname
  	rename_column :clients, :user_name, :username
	end
end

class ChangeColumnsOfClient < ActiveRecord::Migration
  def change
  	remove_column :clients, :email
    remove_column :clients, :password 
  end
end

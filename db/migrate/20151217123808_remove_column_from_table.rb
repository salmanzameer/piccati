class RemoveColumnFromTable < ActiveRecord::Migration
  def change
  	remove_column :clients, :confirmation_password, :string
  
  end
end

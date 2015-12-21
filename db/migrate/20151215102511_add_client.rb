class AddClient < ActiveRecord::Migration
  def change
  	add_column :clients, :first_name, :string
  	add_column :clients, :last_name, :string
  	add_column :clients, :user_name, :string
  	add_column :clients, :email,     :string
  	add_column :clients, :password , :encrypted_password
    end
   add_index("AddClient", "photographer_id")
end

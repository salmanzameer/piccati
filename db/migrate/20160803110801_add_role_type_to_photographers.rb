class AddRoleTypeToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :role_type, :string
  end
end

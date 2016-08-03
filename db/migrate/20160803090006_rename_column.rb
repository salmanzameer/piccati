class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :likes, :user_id, :client_id
  end
end

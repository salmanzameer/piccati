class RemoveClientIdFromPackages < ActiveRecord::Migration
  def change
    remove_column :packages, :client_id, :integer
  end
end

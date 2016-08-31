class AddPackageIdAndRemovePackageToPhotographerClients < ActiveRecord::Migration
  def change
    add_column :photographer_clients, :package_id, :integer
    remove_column :photographer_clients, :package
  end
end

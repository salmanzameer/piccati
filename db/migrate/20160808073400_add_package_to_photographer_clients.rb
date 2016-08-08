class AddPackageToPhotographerClients < ActiveRecord::Migration
  def change
    add_column :photographer_clients, :package, :string
    add_column :photographer_clients, :advance, :string
    add_column :photographer_clients, :total, :string
    add_column :photographer_clients, :balance, :string
    add_column :photographer_clients, :active, :boolean, default: true
  end
end

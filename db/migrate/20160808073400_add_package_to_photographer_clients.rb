class AddPackageToPhotographerClients < ActiveRecord::Migration
  def change
    add_column :photographer_clients, :package, :string
    add_column :photographer_clients, :advance, :integer
    add_column :photographer_clients, :total, :integer
    add_column :photographer_clients, :balance, :integer
    add_column :photographer_clients, :active, :boolean, default: true
  end
end

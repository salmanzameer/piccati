class AddIsConnectedToPhotographerClient < ActiveRecord::Migration
  def change
  	add_column :photographer_clients, :is_connected, :boolean, default: false
  end
end

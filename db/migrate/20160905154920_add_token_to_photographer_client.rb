class AddTokenToPhotographerClient < ActiveRecord::Migration
  def change
  	add_column :photographer_clients, :token, :string
  end
end

class CreatePhotographerClients < ActiveRecord::Migration
  def change
    create_table :photographer_clients do |t|
    	t.integer :photographer_id
    	t.integer :client_id
      t.timestamps null: false
    end
  end
end

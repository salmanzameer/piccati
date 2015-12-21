class AddClientIdToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :client_id, :integer
  end
end

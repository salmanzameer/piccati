class AddclientIdInImage < ActiveRecord::Migration
  def change
  	add_column :images, :client_id, :integer
  end
end

class AddColumnInPhotographer < ActiveRecord::Migration
  def change
  	add_column :photographers, :client_id, :integer
  	add_column :photographers, :event_id, :integer
  end
end

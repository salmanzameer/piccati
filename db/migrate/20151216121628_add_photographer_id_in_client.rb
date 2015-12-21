class AddPhotographerIdInClient < ActiveRecord::Migration
  def change
  	add_column :clients, :photographer_id, :integer
  end
end

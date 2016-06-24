class AddPhotographerIdToImages < ActiveRecord::Migration
  def change
  	add_column :images, :photographer_id, :integer, index: true
  end
end

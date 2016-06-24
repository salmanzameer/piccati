class AddPhotographerIdInAlbums < ActiveRecord::Migration
  def change
  	add_column :albums, :photographer_id, :integer
  end
end

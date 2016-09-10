class AddSlugToPhotographerAndAlbum < ActiveRecord::Migration
  def change
  	add_column :photographers, :slug, :string
  	add_column :albums, :slug, :string
		add_index  :photographers, :slug
		add_index  :albums, :slug
  end
end

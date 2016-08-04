class AddCityToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :city, :string
  end
end

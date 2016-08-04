class AddDescriptionToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :description, :text
  end
end

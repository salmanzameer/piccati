class AddColumnsToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :website, :string
  end
end

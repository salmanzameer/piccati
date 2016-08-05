class AddRationAndBadgeToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :rating, :integer
    add_column :photographers, :badge, :string
  end
end

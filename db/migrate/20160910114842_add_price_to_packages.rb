class AddPriceToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :price, :integer
  end
end

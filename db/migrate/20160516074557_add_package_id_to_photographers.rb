class AddPackageIdToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :package_id, :integer
  end
end

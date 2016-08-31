class SetDefaultsValuesToPhotographer < ActiveRecord::Migration
  def change
    change_column :photographers, :total_connects, :integer, :default => 1
    change_column :photographers, :used_connects, :integer, :default => 0
  end
end

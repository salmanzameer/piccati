class AddDefaultValueToImages < ActiveRecord::Migration
  def change
    change_column :images, :is_liked, :boolean, :default => false
  end
end

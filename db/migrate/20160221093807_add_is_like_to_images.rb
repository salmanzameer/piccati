class AddIsLikeToImages < ActiveRecord::Migration
  def change
    add_column :images, :is_liked, :boolean
  end
end

class RemovePhotographerIdFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :photographer_id, :integer
  end
end

class RemovePhotographerIdInEvent < ActiveRecord::Migration
  def change
  	remove_column :events, :photographer_id, :integer
  end
end

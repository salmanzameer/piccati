class AddPhotographerIdInEvent < ActiveRecord::Migration
  def change
  	add_column :events, :photographer_id, :integer
  end
end

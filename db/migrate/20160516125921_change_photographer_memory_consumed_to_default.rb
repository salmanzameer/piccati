class ChangePhotographerMemoryConsumedToDefault < ActiveRecord::Migration
  def change
    change_column :photographers, :memory_consumed, :integer, :null => false, :default => 0
  end
end

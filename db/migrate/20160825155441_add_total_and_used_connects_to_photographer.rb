class AddTotalAndUsedConnectsToPhotographer < ActiveRecord::Migration
  def change
  	add_column :photographers, :total_connects, :integer
  	add_column :photographers, :used_connects, :integer
  end
end

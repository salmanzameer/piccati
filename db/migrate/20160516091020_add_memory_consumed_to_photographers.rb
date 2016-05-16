class AddMemoryConsumedToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :memory_consumed, :integer
  end
end

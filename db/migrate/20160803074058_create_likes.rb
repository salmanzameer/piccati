class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :like
      t.boolean :unlike
      t.integer :client_id
      t.integer :image_id

      t.timestamps null: false
    end
  end
end

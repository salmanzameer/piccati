class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :picture_dslr_count
      t.integer :video_dslr_count
      t.integer :album_leaves
      t.float :other_city_charges
      t.integer :photographer_id

      t.timestamps null: false
    end
  end
end

class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :storage
      t.integer :connects

      t.timestamps null: false
    end
  end
end

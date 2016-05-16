class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string "name"
      t.integer "price"
      t.integer "memory"
      t.integer "client_id"
      t.timestamps null: false
    end
  end
end

class CreateUserlikes < ActiveRecord::Migration
  def change
    create_table :userlikes do |t|
      t.integer "client_id"
      t.integer "like_type_id"
      t.timestamps null: false
    end
  end
end

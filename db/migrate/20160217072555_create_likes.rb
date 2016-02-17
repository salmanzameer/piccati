class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
    	t.integer "client_id"
    	t.integer "event_id"

        t.timestamps null: false
    end
  end
end

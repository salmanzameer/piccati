class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
    	t.date :event_date
    	t.string :event_name
    	t.integer :guests
    	t.integer :client_id
    	t.integer :photographer_id
      t.timestamps null: false
    end
  end
end

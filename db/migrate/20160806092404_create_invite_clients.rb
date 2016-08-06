class CreateInviteClients < ActiveRecord::Migration
  def change
    create_table :invite_clients do |t|
    	t.string  :email
    	t.integer :photographer_id
      t.timestamps null: false
    end
  end
end

class AddConfirmableToDevise < ActiveRecord::Migration
  def up
  	add_column :clients, :confirmation_token, :string
    add_column :clients, :confirmed_at, :datetime
    add_column :clients, :confirmation_sent_at, :datetime
    add_index  :clients, :confirmation_token, unique: true
    add_column :clients, :unconfirmed_email, :string
    execute("UPDATE clients SET confirmed_at = NOW()")
    add_column :photographers, :confirmation_token, :string
    add_column :photographers, :confirmed_at, :datetime
    add_column :photographers, :confirmation_sent_at, :datetime
    add_column :photographers, :unconfirmed_email, :string
    add_index  :photographers, :confirmation_token, unique: true
    execute("UPDATE photographers SET confirmed_at = NOW()")
  end

  def down
  	remove_columns :photographers, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  	remove_columns :clients, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  end
end

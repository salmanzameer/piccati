class AddOmniauthToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :provider, :string
    add_column :photographers, :uid, :string
  end
end

class AddAuthenticationTokenToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :authentication_token, :integer
  end
end

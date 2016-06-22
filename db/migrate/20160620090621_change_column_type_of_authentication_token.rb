class ChangeColumnTypeOfAuthenticationToken < ActiveRecord::Migration
  def change
  	change_column(:photographers, :authentication_token, :string)
  end
end

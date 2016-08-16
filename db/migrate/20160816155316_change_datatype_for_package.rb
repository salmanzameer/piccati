class ChangeDatatypeForPackage < ActiveRecord::Migration
  def change
    change_column :photographer_clients, :total, 'integer USING CAST(total AS integer)'
    change_column :photographer_clients, :balance, 'integer USING CAST(balance AS integer)'
    change_column :photographer_clients, :advance, 'integer USING CAST(advance AS integer)'
  end
end

class AddEnabledToClients < ActiveRecord::Migration
  def change
    add_column :clients, :enabled, :boolean, default: false
  end
end

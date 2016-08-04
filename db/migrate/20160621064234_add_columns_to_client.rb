class AddColumnsToClient < ActiveRecord::Migration
  def change
  	add_column :clients, :website, :string
  	add_column :clients, :contnumber, :string
  	add_column :clients, :title, :string
  end
end

class AddDescriptionFieldMultipleModels < ActiveRecord::Migration
  def change
    add_column :events, :description, :text
  	add_column :clients, :description, :text
  	add_column :packages, :description, :text
  end
end

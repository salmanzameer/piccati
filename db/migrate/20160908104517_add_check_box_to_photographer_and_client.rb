class AddCheckBoxToPhotographerAndClient < ActiveRecord::Migration
  def change
  	add_column :photographers, :terms_and_condition, :boolean
  	add_column :clients, :terms_and_condition, :boolean
  end
end

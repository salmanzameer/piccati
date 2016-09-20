class AddIsApprovedToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :is_approved, :boolean, default: false
  end
end

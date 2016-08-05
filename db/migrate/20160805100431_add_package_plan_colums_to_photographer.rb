class AddPackagePlanColumsToPhotographer < ActiveRecord::Migration
  def change
  	add_column :photographers, :expired_at, :datetime
  	add_column :photographers, :plan_type,  :string
  end
end

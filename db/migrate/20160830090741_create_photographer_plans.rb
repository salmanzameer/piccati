class CreatePhotographerPlans < ActiveRecord::Migration
  def change
    create_table :photographer_plans do |t|
      t.datetime :expired_at
      t.string :status
      t.integer :plan_id
      t.integer :photographer_id

      t.timestamps null: false
    end
  end
end

class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :photographer_id
      t.string :title
      t.text  :description
      t.timestamps null: false
    end
  end
end

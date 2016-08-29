class AddEventCategory < ActiveRecord::Migration
  def change
  	["Wedding", "Birthday", "Corporate Event"].each do |event|
   		Category.create(name: event)  
 		end 
  end
end

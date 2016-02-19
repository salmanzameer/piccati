class Userlike < ActiveRecord::Base
	belong_to :userlike, :polymorphic => true
end

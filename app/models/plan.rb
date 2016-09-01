class Plan < ActiveRecord::Base
  has_many :photographer_plans
  has_many :photographers, through: :photographer_plans
end

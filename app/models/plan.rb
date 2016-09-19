class Plan < ActiveRecord::Base
  has_many :photographer_plans
  has_many :photographers, through: :photographer_plans

  def self.default
  	find_by_name "Default"
  end
end

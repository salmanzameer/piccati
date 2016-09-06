class HomeController < ApplicationController
	
	def expires  
    @plans = Plan.all
		if current_photographer.photographer_plans.active_plan?
			redirect_to photographer_path(current_photographer)
		end
	end
end

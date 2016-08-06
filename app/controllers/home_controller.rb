class HomeController < ApplicationController
	
	def expires
		flash[:notice] = "You need to upgrade your package plan to continue"
	end

	def plan_update
		current_photographer.update(plan_type: params["plan_type"], expired_at: DateTime.now + 1.year)
		redirect_to photographer_path(current_photographer)
	end
end

module AdminsHelper

	def check_plan_status(status)
		status_i = status.to_i
		text = PhotographerPlan::Status::TEXT[status_i]
		return text 
	end

	def check_plan_type(p)
		trial = "Trial"
		if p.plan_type.blank?
			return trial
		else
			return p.plan_type
		end 
	end

end

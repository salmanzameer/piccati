module AdminsHelper

	def check_p_plan_type(photographer)
		if photographer.plan_type == nil
			return "none"
		elsif photographer.plan_type == "Executive"
			return "Executive"
		elsif photographer.plan_type == "Standard"
			return "Standard"
		elsif photographer.plan_type == "Basic"
			return "Basic"								
		end
	end

end

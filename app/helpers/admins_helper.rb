module AdminsHelper

	def check_plan_type(p)
		trial = "Trial"
		if p.plan_type.blank?
			return trial
		else
			return p.plan_type
		end 
	end

    # PENDING = '2'
    # ACTIVE  = '1'
    # EXPIRED = '0'

  def check_p_plan_status(p_plan) 
  	if p_plan.status == "2"
  		return "Pending"
  	elsif p_plan.status == "1"
			return "Active"
		elsif p_plan.status == "0"
			return "Expired"
		else
			return "none"
		end  				

  end

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

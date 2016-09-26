module AdminsHelper

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
end

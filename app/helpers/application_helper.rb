module ApplicationHelper

	def default_url
		if photographer_signed_in?
			photographer_path(current_photographer)
		else
			root_path
		end
	end
end

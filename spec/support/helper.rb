module Helper


	include Warden::Test::Helpers

	def sign_in(resource)
		#binding.pry
		# resource ||= FactoryGirl.create :photographer
 		# resource ||= resource_or_scope
    	scope = Devise::Mapping.find_scope!(resource)
    	login_as(resource, scope: scope)
	end
	
end


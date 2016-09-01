class HomeController < ApplicationController
	
	def expires
		flash[:notice] = "You need to upgrade your package plan to continue"
	end
end

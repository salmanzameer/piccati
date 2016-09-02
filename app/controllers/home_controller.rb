class HomeController < ApplicationController
	
	def expires
		flash[:notice] = "You need to upgrade your package plan to continue. if you have already upgraded your plane please wait, admin will approve it as soon as possible "
	end
end

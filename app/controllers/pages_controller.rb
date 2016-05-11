class PagesController < ApplicationController

	def login
		@client = Client.where(email: params[:email]).first
		
		if @client
			encrypt_pw = Digest::SHA2.hexdigest(@client.authentication_token + params[:password])
			
			if encrypt_pw == @client.password
				redirect_to client_events_path(@client.id)
			else
				render json: { status: "002", status: 'wrong password' }
			end
		
		else	
			render json: { status: "002", status: 'wrong email' }
		end
	end
	
end

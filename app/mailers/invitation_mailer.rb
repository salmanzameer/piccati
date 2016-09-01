class InvitationMailer < ApplicationMailer
	
	def client_invitation(current_photographer, email)
		@photographer = current_photographer
		@client = Client.find_by_email(email)
		mail to: "#{email}", subject: "Invitation"
	end

	def client_acknowledge(current_photographer, client)
		@photographer = current_photographer
		@client = client
		mail to: "#{@client.email}", subject: "Photographer added you as a client"
	end
end
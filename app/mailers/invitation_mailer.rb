class InvitationMailer < ApplicationMailer
	
	def client_invitation(current_photographer, email)
		@photographer = current_photographer
		mail to: "#{email}", subject: "Invitation"
	end

	def client_acknowledge(current_photographer, email)
		@photographer = current_photographer
		mail to: "#{email}", subject: "Invitation"
	end
end
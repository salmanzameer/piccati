class UserNotifier < ApplicationMailer

	def client_request_event_email(enquiry)
	  @enquiry = enquiry
	  @client = Client.find(enquiry.client_id)
	  @photographer = Photographer.find(enquiry.photographer_id)
	  mail( to: @photographer.email,
	  subject: 'Event request')
	end

	def website_form_email(name,email,message)
		@name = name
		@email = email
		@message = message
		mail( to: "info@piccati.com",
	  subject: 'Contact Us')
	end
end

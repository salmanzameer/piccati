class UserNotifier < ApplicationMailer

	def client_request_event_email(enquiry)
	  @enquiry = enquiry
	  @client = Client.find(enquiry.client_id)
	  @photographer = Photographer.find(enquiry.photographer_id)
	  mail( to: @photographer.email,
	  subject: 'Event request')
	end

end

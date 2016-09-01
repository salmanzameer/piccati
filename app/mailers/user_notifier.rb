class UserNotifier < ApplicationMailer

	def client_request_event_email(enquiry,event_name)
	  @enquiry = enquiry
	  @event_name = event_name
	  @client = Client.find(enquiry.client_id)
	  @photographer = Photographer.find(enquiry.photographer_id)
	  mail( to: @photographer.email, subject: '#{@client.fullname} requested connection to events image gallery.')
	end

	def website_form_email(name,email,message)
		@name = name
		@email = email
		@message = message
		mail( to: "info@piccati.com", subject: 'Contact Us')
	end

	def connection_added(photographer,client)
		@photographer = photographer
		@client = client
		mail( to: @client.email, subject: 'Connected with you.')
	end

	def plan_upgraded(photographer)
		@photographer = photographer
		mail( to: @photographer.email, subject: 'Upgraded Plan')
	end
end
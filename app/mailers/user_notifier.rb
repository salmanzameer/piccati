class UserNotifier < ApplicationMailer

	def client_request_event_email(enquiry,event_name)
	  @enquiry = enquiry
	  @event_name = event_name
	  @client = Client.find(enquiry.client_id)
	  @photographer = Photographer.find(enquiry.photographer_id)
	  mail( to: @photographer.email, subject: 'Event Request')
	end

	def website_form_email(name,email,message)
		@name = name
		@email = email
		@message = message
		mail( to: "Piccati <admin@piccati.com>", subject: 'Contact Us')
	end

	def connection_added(photographer,client)
		@photographer = photographer
		@client = client
		mail( to: @client.email, subject: "Photographer #{photographer.firstname} is now connected with you")
	end

	def plan_upgraded(photographer)
		@photographer = photographer
		mail( to: @photographer.email, subject: 'Upgrade Plan')
	end

	def share_download_url(photographer, client, token)
		@photographer = photographer
		@client = client
		@token	= token
		mail( to: @client.email, subject: 'Download images url')
	end
end
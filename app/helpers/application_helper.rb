module ApplicationHelper

  def remaining_days
    ((current_photographer.created_at + 10.days).to_date - Date.today).round
  end
  def find_event(path)
    @path = Rails.application.routes.recognize_path(path)
    if !@path[:client_id].present?
      #@photographer = Photographer.find_by_id @path[:photographer_id]
      @client = current_photographer.clients.first || Client.first
      @event = @client.events.first || Event.first
      @path = @path.merge({:client_id=>@client.id.to_s, :id=>@event.id.to_s})
    end
    session[:save_client] = @path
  end

  # def check_valid_url(path)
  #   @photographer = Photographer.find_by_id path[:photographer_id]
  #   @client = @photographer.clients.find_by_id path[:client_id]
  #   @event = @client.events.find_by_id path[:id]
  #   if !(@photographer.present? && @client.present? && @event.present?)
  #     message =  "no record"
  #   end
  #   return message
  # end

	def default_url
		if photographer_signed_in?
			photographer_path(current_photographer)
		else
			root_path
		end
	end
end
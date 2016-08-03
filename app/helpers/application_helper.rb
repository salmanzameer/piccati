module ApplicationHelper

  def find_event(path)
    @path = Rails.application.routes.recognize_path(path)
    if !@path[:client_id].present?
      @p = Photographer.find_by_id @path[:photographer_id]
      @c = @p.clients.first
      @e = @c.events.first
      @path = @path.merge({:client_id=>@c.id.to_s, :id=>@e.id.to_s})
    end
    session[:save_client] = @path
  end

	def default_url
		if photographer_signed_in?
			photographer_path(current_photographer)
		else
			root_path
		end
	end
end
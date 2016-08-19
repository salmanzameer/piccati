class PhotographersController < ApplicationController
 before_filter :authenticate_photographer!
 before_filter :trial_expired?

  def show
    @photographer = current_photographer 
    @page_name = "Studio Management"
  end

  def edit
    @photographer = Photographer.find(current_photographer)
  end

  def sign_in
    redirect_to new_photographer_session_path
  end

  def events_info
    start_of_day = Date.today.to_datetime.beginning_of_day
    end_of_day = Date.today.to_datetime.end_of_day
    @calendar_event = current_photographer.events
    @events = current_photographer.events.where("start_time >= ? and start_time <= ?", start_of_day, end_of_day)
    @page_name = "My Calendar"
    respond_to do |format|
      format.js
      format.html
    end
  end

  def connect_client
    connected_clients = current_photographer.photographer_clients.is_connected?.count
    if ((connected_clients >= 1) && (current_photographer.expired_at.blank?))
      render text: "You can connect with only 1 client during trial period"
    else  
      @client = Client.find_by_id params[:client_id]
      current_photographer.photographer_clients.where(client_id: @client.id).first.update_attribute('is_connected', true)
      render text: @client.firstname + " now connected with you."
    end
  end

  def update_password
    @photographer = Photographer.find(current_photographer)  
    if @photographer.update_with_password(photographer_params)          
      redirect_to photographer_path(current_photographer)
    else
      render 'edit'
    end
  end

  def new_achievement
    2.times do
      current_photographer.achievements.new
    end
  end

  def settings
    clients_ids = current_photographer.photographer_clients.where(is_connected: false).pluck(:client_id)
    @clients = Client.where("id in (?)", clients_ids)
    @page_name = "Connects"     
  end

  def profile
    @page_name = "My Profile"
  end

  def setting_partial
    return render partial: "#{params["partial_name"]}"
  end

  def add_achievements
    @achievements = current_photographer.achievements.create(photographer_params)
    redirect_to photographer_path(current_photographer)
  end
  
  private

  def photographer_params
    params.require(:photographer).permit( :current_password, :password, :password_confirmation, achievement_attributes: [:title, :description])
  end
end

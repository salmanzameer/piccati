class PhotographersController < ApplicationController
 before_filter :authenticate_photographer!
 before_filter :trial_expired?

  def show
    @photographer = current_photographer 
    @page_name = "Home"
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
    @page_name = "Calender"
    respond_to do |format|
      format.js
      format.html
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

  def add_achievements
    @achievements = current_photographer.achievements.create(photographer_params)
    redirect_to photographer_path(current_photographer)
  end
  
  private

  def photographer_params
    params.require(:photographer).permit( :current_password, :password, :password_confirmation, achievement_attributes: [:title, :description])
  end
end

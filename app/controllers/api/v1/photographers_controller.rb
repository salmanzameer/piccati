class Api::V1::PhotographersController < ApplicationController
 before_filter :authenticate_photographer!

  def index
  end

  def profile
   
  end

  def show
 
    @photographer = current_photographer 
    #render :json => { photographer: @photographer }
  end
  def edit
     @photographer = Photographer.find(current_photographer)
  end

  def new
    
  end
    
  def delete
  end
  def sign_in
    redirect_to new_photographer_session_path
  end
  def eventsinfo
    @event = current_photographer.events
  end
  def update_password
    @photographer = Photographer.find(current_photographer)
    if @photographer.update_with_password(photographer_params)          
 
        redirect_to  api_v1_photographer_path(current_photographer)
     else
      render 'edit'
    end
  end
  private
 def photographer_params
 
   params.require(:photographer).permit(:current_password,:password,:password_confirmation)
 end
end

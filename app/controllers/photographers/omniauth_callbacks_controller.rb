class Photographers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @photographer = Photographer.from_omniauth(request.env["omniauth.auth"])
    if @photographer.persisted?
      sign_in(@photographer)
      redirect_to edit_photographer_registration_path(@photographer)
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_photographer_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

end
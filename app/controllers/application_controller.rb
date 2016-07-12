class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_photographer

  def set_current_photographer
    Photographer.current_photographer = current_photographer
  end

protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) do |u|
  		u.permit(:title,:firstname,:lastname,:contnumber,:username, :email,:password,:password_confirmation)
    end 
    
    devise_parameter_sanitizer.for(:account_update) do |u|
     u.permit(:title,:firstname,:lastname,:contnumber,:username,:email,:password,:password_confirmation,:current_password, :avatar, :watermark_logo)
    end
  end

  def after_sign_in_path_for(resource)
    photographer_path(resource)
  end

  def current_client
    @client = Client.where(email: params[:email], password: params[:password]).first 
  end

  def client_match_token
    @client = Client.find_by_authentication_token(params[:authentication_token])
  end
end 

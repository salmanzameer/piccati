class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include PublicActivity::StoreController

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) do |u|
  		u.permit(:title,:firstname,:lastname,:contnumber,:username, :email,:password,:password_confirmation, :role_type)
    end 
    
    devise_parameter_sanitizer.for(:account_update) do |u|
     u.permit(:title,:firstname,:lastname,:contnumber,:username,:email, :role_type, :password,:password_confirmation,:current_password, :feature_image, :avatar, :watermark_logo)
    end
  end

  def after_sign_in_path_for(resource)
    if resource.class.name == "Client"
      download_app_path
    elsif resource.class.name == "Admin"
      admins_dashboard_path
    else
      photographer_path(resource)
    end
  end

  def after_sign_out_path_for(resource)
    resource == :client ? new_client_session_path : photographer_path(resource)
    if resource == :client
      new_client_session_path
    elsif resource == :admin
      new_admin_session_path
    else
      photographer_path(resource)
    end
  end

  def client_match_token
    @client = Client.find_by_authentication_token(params[:authentication_token])
  end

  def remaining_days
    ((current_photographer.created_at + 15.days).to_date - Date.today).round
  end

  def trial_expired?
    if current_photographer
      if current_photographer.expired_at.blank?
        if (remaining_days <= 0)
          redirect_to expires_path
        end
      elsif !current_photographer.photographer_plans.active_plan?
        redirect_to expires_path
      end
    end
  end
end 
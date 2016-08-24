module Authentication
  class Authenticate < Grape::API
    desc "Login"
    params do
      requires :email, type: String
      requires :password, type: String
    end
    
    post :login, rabl: "v1/authentication/login" do

      @user = Client.find_by_email params[:email]
      @user = Photographer.find_by_email params[:email] unless @user.present?

      unless @user && @user.valid_password?(params[:password])
        throw :error, status: 404, message: "Invalid username/password"
      end
    end

    desc "Update User profile picture"
    params do
      requires :id,     type: Integer
      requires :avatar, type: Rack::Multipart::UploadedFile
      requires :authentication_token, type: String
    end
    
    put :update_user, rabl: "v1/authentication/update_user" do
      
      @user = Client.find_by_id_and_authentication_token(params[:id], params[:authentication_token])
      @user = Photographer.find_by_id_and_authentication_token(params[:id], params[:authentication_token]) unless @user.present?

      unless @user
        throw :error, status: 404, message: "User not found"
      end
      @user.update_attribute('avatar', params[:avatar].tempfile)
    end  

    desc "Forgot password (STEP I)"
    params do
      requires :email, type: String
    end
    
    post :forgot_password, rabl: "v1/authentication/forgot_password" do
      @user = Client.find_by_email params[:email]
      @user = Photographer.find_by_email params[:email] unless @user.present?

      unless @user
        throw :error, status: 404, message: "User not found"
      end

      @user.class.send_reset_password_instructions(@user)
    end

    desc "Change my password"
    params do
      requires :reset_password_token, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    
    put :change_my_password, rabl: "v1/authentication/change_my_password" do

      @user = Photographer.reset_password_by_token(params)
      @user = Client.reset_password_by_token(params) unless @user.persisted?

      unless @user.persisted?
        throw :error, status: 404, message: "Invalid reset password token"
      end
      
    end

  end
end
module Authentication
  class Authenticate < Grape::API
    desc "Login"
    params do
      requires :email, type: String
      requires :password, type: String
    	requires :role_type, type: String
    end
    
    post :login, rabl: "v1/authentication/login" do
      rolee = params[:role_type].titleize
      role = ["Freelauncer","Studio"].include?(rolee) ? "Photographer" : "Client"
      role = role.constantize 

      @user = role.find_by_email(params[:email])
      unless @user && @user.valid_password?(params[:password])
        throw :error, status: 404, message: "Invalid username/password"
      end
    end

    desc "Update User profile picture"
    params do
      requires :id,     type: Integer
      requires :avatar, type: Rack::Multipart::UploadedFile
      requires :role_type, type: String
    end
    
    put :update_user, rabl: "v1/authentication/update_user" do
      rolee = params[:role_type].titleize
      role = ["Freelauncer","Studio"].include?(rolee) ? "Photographer" : "Client"
      role = role.constantize 

      @user = role.find_by_id(params[:id])
      unless @user
        throw :error, status: 404, message: "User not found"
      end
      @user.update(avatar: params[:avatar].tempfile)
    end  
  end
end
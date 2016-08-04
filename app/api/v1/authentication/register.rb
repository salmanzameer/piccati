module Authentication
  class Register < Grape::API

    desc "Register user and create access token"
      params do
        requires :title, type: String
        requires :firstname, type: String
        requires :lastname, type: String
        requires :username, type: String
        requires :contnumber, type: String
        requires :email, type: String
        requires :city, type: String
        requires :password, type: String
        optional :website, type: String
        optional :avatar, type: Rack::Multipart::UploadedFile
        requires :role_type, type: String   
      end
    post :register, rabl: "v1/authentication/register"  do
      rolee = params[:role_type].titleize
      role = ["Freelauncer","Studio"].include?(rolee) ? "Photographer" : "Client"
      signup = role.constantize 
      @user = signup.new(
        title:     params[:title],
        firstname:      params[:firstname],
        lastname:         params[:lastname],
        username:      params[:username],
        contnumber:  params[:contnumber],
        email:       params[:email],
        city:       params[:city],
        password:       params[:password],
        website:       params[:website]
        )
      if signup.name == "Photographer"
        @user.role_type = rolee
      end
      if params[:avatar].present?
        new_file = ActionDispatch::Http::UploadedFile.new(params[:avatar])
        @user.avatar = new_file
      end
      if @user.valid?        
        user_token = @user.ensure_authentication_token
        @user.save  
      else
        throw :error, status: 404, message: "User is invalid."
      end
    end
  end
end
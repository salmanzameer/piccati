module Authentication
  class Register < Grape::API

    desc "Register user and create access token"
    params do
      requires :title, type: String
      requires :firstname, type: String
      requires :lastname, type: String
      requires :contnumber, type: String
      requires :email, type: String
      requires :city, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
      optional :website, type: String
      optional :avatar, type: Rack::Multipart::UploadedFile
      requires :role_type, type: String
      optional :terms_and_condition, type: Boolean   
    end
    post :register, rabl: "v1/authentication/register"  do
      @client = Client.find_by_email params[:email]
      @photographer = Photographer.find_by_email params[:email]

      if @client.present? || @photographer.present?
        throw :error, status: 404, message: "Email already has been taken."
      end

      role_type = params[:role_type].titleize
      role = ["Freelancer","Studio"].include?(role_type) ? "Photographer" : "Client"
      klass = role.constantize 
      @user = klass.new(
        title:        params[:title],
        firstname:    params[:firstname],
        lastname:     params[:lastname],
        contnumber:   params[:contnumber],
        email:        params[:email],
        city:         params[:city],
        password:     params[:password],
        password_confirmation:     params[:password_confirmation],
        website:      params[:website],
        terms_and_condition: params[:terms_and_condition]
        )
      if klass.name == "Photographer"
        @user.role_type = role_type
      end
      
      if params[:avatar].present?
        new_file = ActionDispatch::Http::UploadedFile.new(params[:avatar])
        @user.avatar = new_file
      end
      
      if @user.valid?        
        user_token = @user.ensure_authentication_token
        @user.save  
      else
        throw :error, status: 404, message: @user.errors.messages
      end
    end
  end
end
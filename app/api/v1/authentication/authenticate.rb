module Authentication
  class Authenticate < Grape::API
    desc "Login"
    params do
      requires :email, type: String
      requires :password, type: String
    	requires :role_type, type: String
    end
    
    post :login, rabl: "v1/authentication/login" do
      login = params[:role_type].titleize.constantize
      @user = login.find_by_email(params[:email])
      unless @user && @user.valid_password?(params[:password])
        throw :error, status: 404, message: "Invalid username/password"
      end
    end  
  end
end
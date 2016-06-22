module Snapper
  class Authenticate < Grape::API
    
    desc "Returns authentication_token on valid login"
    params do
      requires :email, type: String
      requires :password, type: String
    end
    
    post :login_photographer, rabl: "v1/snapper/login_photographer" do

      @photographer = Photographer.find_by_email(params[:email]) 
      
      unless @photographer && @photographer.valid_password?(params[:password])
        throw :error, status: 404, message: "Invalid username/password"
      end
    end

  end
end
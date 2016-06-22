module Customer
  class Authenticate < Grape::API
    desc "Login Client"
    params do
      requires :email, type: String
      requires :password, type: String
    end
    
    post :login, rabl: "v1/customer/login" do
      @client = Client.find_by_email(params[:email])
      unless @client && @client.valid_password?(params[:password])
        throw :error, status: 404, message: "Invalid username/password"
      end
    end  
  end
end

module Customer
  class Authenticate < Grape::API
    desc "Login Client"
    params do
      requires :email, type: String
      requires :password, type: String
    end
    
    post :login, rabl: "customer/login" do
      
      @client = Client.find_by_email(params[:email])
        unless @client.blank?
          encrypt_pw = Digest::SHA2.hexdigest(@client.authentication_token + params[:password])
        end
      
      unless @client && encrypt_pw == @client.password
        throw :error, status: 404, message: "Invalid username/password"
      end
    end
  end
end

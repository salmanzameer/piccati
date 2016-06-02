module Customer
  class Authenticate < Grape::API
    desc "Login Client"
    params do
      requires :email, type: String
      requires :password, type: String
    end
    
    post :login, rabl: "v1/customer/login" do
      @client = Client.find_by_email(params[:email])
      
      throw :error, status: 400, message: "Client not found." if @client.blank?

      if @client.present?
        encrypt_pw = Digest::SHA2.hexdigest(@client.authentication_token + params[:password])
      end
      
      unless @client && encrypt_pw == @client.password
        throw :error, status: 404, message: "Invalid username/password"
      end
    end
  end
end

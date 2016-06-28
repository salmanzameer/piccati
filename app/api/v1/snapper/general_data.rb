module Snapper
  class GeneralData < Grape::API
  	desc "Get all photographers list"
	  get :photographers, rabl: "v1/snapper/photographers_index" do
	    @photographer = Photographer.all 
	    unless @photographer
	      throw :error, status: 404, message: "Photographer not found!"
	    end
	  end

	  desc "Get photographer profile"
    params do
      requires :authentication_token, type: String
      requires :role_type,            type: String
      requires :id,                   type: Integer
    end

    get "/photographer/:id", rabl: "v1/snapper/photographer_profile" do
      profile = params[:role_type].titleize.constantize
      @user = profile.find_by_id_and_authentication_token(params[:id], params[:authentication_token])
      unless @user
        throw :error, status: 404, message: "User not found!"
      end
    end
  
  end
end
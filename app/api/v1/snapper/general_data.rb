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
      requires :client_id,            type: String
    end

    get "/photographer/:id", rabl: "v1/snapper/photographer_profile" do

    	@client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      @photographer = Photographer.find_by_id(params[:id])
    	unless @photographer
        throw :error, status: 404, message: "Photographer not found!"
      end
      @album = @photographer.albums.first 
      @image = @album.images.sample
      unless @image
        throw :error, status: 404, message: "Album/Image not found!"
      end
    end
  
  end
end
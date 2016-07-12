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
      requires :role_type,            type: String
      requires :id,                   type: Integer
    end

    get "/photographer/:id", rabl: "v1/snapper/photographer_profile" do
      profile = params[:role_type].titleize.constantize
      @user = profile.find_by_id(params[:id])
      unless @user
        throw :error, status: 404, message: "User not found!"
      end
    end
    
    desc "Get public album"
    params do
      requires :id,                   type: Integer
      requires :photographer_id,      type: Integer
    end

    get "/photographer/:photographer_id/album/:id", rabl: "v1/snapper/album_show" do
      @photographer = Photographer.find(params[:photographer_id])
      unless @photographer
        throw :error, status: 404, message: "Photographer not found!"
      end
      @album =  @photographer.albums.find(params[:id])
      unless @album
        throw :error, status: 404, message: "Album not found!"
      end
    end

  end
end
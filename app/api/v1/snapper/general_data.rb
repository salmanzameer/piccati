module Snapper
  class GeneralData < Grape::API

    helpers do
      def klass_obj(user_type, id)
        type = user_type.titleize
        klass = ["Freelancer","Studio"].include?(type) ? "Photographer" : "Client"
        klass.constantize.find_by_id(id) 
      end
    end
  	
    desc "Get all photographers list"
	  params do
      optional :page,                   type: Integer
    end
    
    get :photographers, rabl: "v1/snapper/photographers_index" do
	    @photographer = Photographer.where("confirmed_at IS NOT NULL AND is_approved IS TRUE").paginate( page: params[:page], per_page: 10 ).order("created_at ASC")
	    
      unless @photographer
	      throw :error, status: 404, message: "Photographer not found!"
	    end
      
      @total_photographers = @photographer.count
	  end

	  desc "Get photographer profile"
    params do
      requires :authentication_token, type: String
      requires :requester_type,       type: String
      requires :requester_id,         type: String
      requires :user_type,            type: String
      requires :user_id,              type: Integer
    end

    get "/profile", rabl: "v1/snapper/profile" do
      
      @requester = klass_obj(params[:requester_type], params[:requester_id])
      
      unless @requester
        throw :error, status: 404, message: "User not found!"
      end

      @user = klass_obj(params[:user_type], params[:user_id])
      
      unless @user
        throw :error, status: 404, message: "User not found!"
      end
    end
    
    desc "Get public album"
    params do
      requires :id,                   type: Integer
      requires :photographer_id,      type: Integer
      requires :requester_id,         type: Integer
      requires :requester_type,       type: String
      optional :page,                 type: Integer
    end

    get "/photographer/:photographer_id/album/:id", rabl: "v1/snapper/album_show" do
      
      @requester = klass_obj(params[:requester_type], params[:requester_id])
      
      unless @requester
        throw :error, status: 404, message: "Requester not found!"
      end

      @photographer = Photographer.find(params[:photographer_id])
      
      unless @photographer
        throw :error, status: 404, message: "Photographer not found!"
      end
      
      @album =  @photographer.albums.find(params[:id])
      
      unless @album
        throw :error, status: 404, message: "Album not found!"
      end
      
      @images = @album.images.paginate( page: params[:page], per_page: 6 )
      @total_images = @images.count 
    end

    desc "Get monthly/yearly calendar events"
    params do
      requires :photographer_id,      type: Integer
      requires :authentication_token, type: String
      requires :calendar_type,        type: String
    end

    get "/photographer/:photographer_id/calendar_events", rabl: "v1/snapper/calendar_events" do
      
      @photographer = Photographer.find_by_id_and_authentication_token(params[:photographer_id],params[:authentication_token])
      
      unless @photographer
        throw :error, status: 404, message: "Photographer not found!"
      end
      
      calendar = params[:calendar_type]
      @events = @photographer.events.where(start_time: Date.today..Date.today + 1.send(calendar))
    end
  end
end
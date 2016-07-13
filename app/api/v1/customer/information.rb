module Customer
  class Information < Grape::API
      
    desc "Get all events"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
      optional :page,                 type: Integer
    end

    get "/all_events", rabl: "v1/customer/all_events" do
      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      @events = @client.events.paginate( page: params[:page], per_page: 6 ).order("created_at DESC")
      @total_events = @events.count
    end

    desc "Get single event images"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
      requires :event_id,             type: String
      optional :page,                 type: Integer
    end

    get "/all_images", rabl: "v1/customer/all_images" do

      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      
      @event = Event.find_by_id(params[:event_id])
      unless @event
        throw :error, status: 404, message: "Event not found!"
      end
      @images = @event.images.paginate( page: params[:page], per_page: 6 )
      @total_images = @images.count
    end

    desc "Like image"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
      requires :image_id,             type: String
      requires :is_liked,             type: Boolean
    end

    post "/like", rabl: "v1/customer/like" do
      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      
      @image = Image.find_by_id(params[:image_id])
      unless @image
        throw :error, status: 404, message: "Image not found!"
      end
      @image.update_attributes(is_liked: params[:is_liked])
    end

    desc "Get all liked images"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
      requires :event_id,             type: String 
      optional :page,                 type: Integer
         
    end

    get "/liked_images", rabl: "v1/customer/liked_images" do

      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      @event = Event.find_by_id(params[:event_id])
      unless @event
        throw :error, status: 404, message: "Event not found!"
      end
      @images = @event.images.where(is_liked: true).paginate( page: params[:page], per_page: 6 )
      @total_images = @images.count    
    end
  end
end
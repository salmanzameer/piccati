module Customer
  class Information < Grape::API
      
    desc "Get all events"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
    end

    get "/all_events", rabl: "customer/all_events" do
      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      @events = @client.events
    end

    desc "Get single event images"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
      requires :event_id,            type: String
    end

    get "/all_images", rabl: "customer/all_images" do

      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      
      @event= Event.find_by_id(params[:event_id])
      unless @event
        throw :error, status: 404, message: "Event not found!"
      end
      @images = @event.images
    end

    desc "Like image"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
      requires :image_id,             type: String
      requires :is_liked,             type: Boolean
    end

    post "/like", rabl: "customer/like" do
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
    end

    get "/liked_images", rabl: "customer/liked_images" do

      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      @images = Image.where(is_liked: true)
    end

    get "/photographer_profile", rabl: "photographer_profile" do

      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      @photographer = @client.photographer
    end
  end
end
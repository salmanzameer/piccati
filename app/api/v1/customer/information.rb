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
      @events = @client.events.paginate( page: params[:page], per_page: 6 ).order("created_at ASC")
      @total_events = @events.count
    end

    desc "Like/Unlike public image"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
      requires :image_id,             type: String
      requires :like,                type: Boolean
    end

    post "/like_public_image", rabl: "v1/customer/like_public_image" do
      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      
      @image = Image.find_by_id(params[:image_id])
      unless @image
        throw :error, status: 404, message: "Image not found!"
      end

      @like = @image.likes.where({client_id: @client.id}).first_or_initialize(client_id: @client.id)
      @like.update(like: params[:like], unlike: !params[:like])

      message = @like.like ? "like" : "unlike"
      @image.create_activity(key: "#{message} a image", owner: @client)

    end

    desc "Get selected images of client"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
    end

    get "/selected_images", rabl: "v1/customer/selected_images" do

      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      @images = @client.images.where("is_liked = ?", true)
    end

    desc "Get liked images of client"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
    end

    get "/clients_liked_images", rabl: "v1/customer/clients_liked_images" do

      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      ids = @client.likes.where(like: true).pluck(:image_id)
      @images = Image.where("id in (?)", ids)
    end
##########################################
    desc "Get images of photographers liked followed by client (feed)"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
    end

    get "/get_client_feed", rabl: "v1/customer/get_client_feed" do

      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      @activities = @client.get_followings
    end
######################################
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

      message = @image.is_liked ? "like" : "unlike"
      @image.create_activity(key: "#{message} a image", owner: @client)
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

    desc "follow photographer"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
      requires :photographer_id,      type: String
      requires :follow_type,          type: String
    end

    post "/follow", rabl: "v1/customer/follow" do
      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      photographer = Photographer.find(params[:photographer_id])
      @client.send("#{params[:follow_type]}", photographer)

      photographer.create_activity(key: "follow a person", owner: @client)
    end
  end
end
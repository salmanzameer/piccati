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
      @like = @image.likes.where({client_id: @client.id}).first_or_initialize
      @like.update(like: params[:like], unlike: !params[:like])

      message = @like.like ? "liked" : "unliked"
      @image.create_activity(key: "#{message} an image of #{@image.imageable.name}", owner: @client, recipient: @image.imageable.photographer)

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
      events = @client.events.pluck(:id)

      @images = Image.where(imageable_type: "Event", is_liked: true).where("imageable_id in (?)", events)
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
      ids = @client.likes.where(like: true).pluck(:image_id).uniq

      @images = Image.where("id in (?)", ids)
    end

    desc "Get images of photographers liked followed by client (feed)"
    
    params do
      requires :authentication_token, type: String
      requires :user_id,              type: String
    end

    get "/feed", rabl: "v1/customer/get_client_feed" do

      user = Client.find_by_id_and_authentication_token(params[:user_id], params[:authentication_token])
      
      unless user
       user =  Photographer.find_by_id_and_authentication_token(params[:user_id], params[:authentication_token])
      end

      unless user
        throw :error, status: 404, message: "User not found!"
      end
      @activities = user.get_activity
    end

    desc "Search Photographer"
    params do
      requires :search_string, type: String
      requires :authentication_token, type: String
      requires :requester_id,         type: String
    end

    get "/search_photographer", rabl: "v1/customer/search_photographer" do

      @requester = Client.find_by_id_and_authentication_token(params[:requester_id], params[:authentication_token])
      @requester = Photographer.find_by_id_and_authentication_token(params[:requester_id], params[:authentication_token]) unless @requester.present?

      unless @requester.present?
        throw :error, status: 404, message: "Requester not found!"
      end

      search = params[:search_string]
      @photographers = Photographer.where("(firstname ILIKE ?) AND confirmed_at IS NOT NULL AND is_approved IS TRUE", "%#{search}%")
    end

    desc "Get images with likes greater than 1000 (collection feed)"
    params do
      requires :authentication_token, type: String
      requires :requester_id,         type: String
      optional :page,                 type: Integer
    end
    
    get "/get_collection_feed", rabl: "v1/customer/get_collection_feed" do

      @requester = Client.find_by_id_and_authentication_token(params[:requester_id], params[:authentication_token])
      @requester = Photographer.find_by_id_and_authentication_token(params[:requester_id], params[:authentication_token]) unless @requester.present?

      unless @requester.present?
        throw :error, status: 404, message: "Requester not found!"
      end

      @images = Image.where(imageable_type: "Album").order("likes_count DESC").paginate( page: params[:page], per_page: 10 )
    end

    desc "Get images of photographers liked followed by client (feed)"
    params do
      requires :authentication_token, type: String
      requires :photographer_id,      type: String
    end

    get "/get_followers", rabl: "v1/customer/get_followers" do

      @photographer = Photographer.find_by_id_and_authentication_token(params[:photographer_id], params[:authentication_token])
      unless @photographer
        throw :error, status: 404, message: "Photographer not found!"
      end

      @followers = @photographer.followers
      @follower_count = @followers.count
    end

    desc "Get followings"
    params do
      requires :authentication_token, type: String
      requires :client_id,      type: Integer
    end

    get "/get_followings", rabl: "v1/customer/get_followings" do

      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end

      puts "okok"
      @followings = @client.all_following
      puts "okok1111"
      @following_count = @followings.count
      puts "okok2222"
    end

    desc "Get clients of a photographer"
    params do
      requires :authentication_token, type: String
      requires :photographer_id,      type: Integer
    end

    get "/get_photographer_clients", rabl: "v1/customer/get_photographer_clients" do

      @photographer = Photographer.find_by_id_and_authentication_token(params[:photographer_id], params[:authentication_token])
      unless @photographer
        throw :error, status: 404, message: "Photographer not found!"
      end

      clients = @photographer.photographer_clients.is_connected?.pluck(:client_id).uniq
      @clients = Client.where("id in (?)", clients)
    end

    desc "Get Event Categories"

    get "/get_event_categories", rabl: "v1/customer/get_event_categories" do

      @categories = Category.all

      unless @categories.present?
        throw :error, status: 404, message: "No event types found."
      end
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
      
      @event = @client.events.find_by_id(params[:event_id])

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

      message = @image.is_liked ? "selected" : "unselected"
      @image.create_activity(key: "#{message} an image", owner: @client, recipient: @image.imageable.photographer)
    end

    desc "Get all liked images"
    params do
      requires :authentication_token, type: String
      requires :client_id,            type: String
      requires :event_id,             type: String 
      optional :page,                 type: Integer
         
    end

    #[ NOT IN USE ]
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
      
      photographer.create_activity(key: "started following you", owner: @client, recipient: photographer)
    end

    desc "Request photographer"
    params do
      requires :client_id,     type: Integer
      requires :authentication_token, type: String
      requires :photographer_id,     type: Integer    
      requires :event_name,     type: String
      requires :event_date,     type: Date
      requires :guests,         type: Integer
    end

    post "/request", rabl: "v1/customer/request" do
      
      @client = Client.find_by_id_and_authentication_token(params[:client_id], params[:authentication_token])
      unless @client
        throw :error, status: 404, message: "Client not found!"
      end
      @enquiry = Enquiry.new(
        client_id: params[:client_id],
        photographer_id: params[:photographer_id],
        event_name: params[:event_name],
        event_date: params[:event_date],
        guests:     params[:guests] 
        )
      @enquiry.save
      @enquiry.create_activity(key: "sent a request for an event", owner: @client, recipient: @enquiry.photographer)
      UserNotifier.client_request_event_email(@enquiry,params[:event_name]).deliver_now
    end 
    desc "Get email form from piccati.com"
    params do
      requires :email,    type: String
      requires :name,     type: String
      requires :message,  type: String
    end

    get "/email_form", rabl: "v1/customer/email_form" do
      @name = params[:name]
      @email = params[:email]
      @message = params[:message]
      UserNotifier.website_form_email(@name,@email,@message).deliver_now
    end

  end
end
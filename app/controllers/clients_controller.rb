class ClientsController < ApplicationController
  
  def index
    @clients = current_photographer.clients
    @current_client = @clients.first
    @client = Client.new
    @event = @current_client.events.new if @current_client
  end

  def show
    if current_photographer.present?
      @client = current_photographer.clients.find(params[:id])
      @events = @client.events
     
    else
       client_match_token
      if
        @client.present?
        @events
        render :json => @client.to_json( :only =>[:id,:firstname,:lastname,:username,:email] )  
      else
        render json: {status: 'error'}
      end
    end
  end

  def new
    @client = current_photographer.clients.new 
  end

  def create
    @client = Client.where(email: params[:client][:email]).first
    unless @client
      @client = Client.create(clientsparams)
    end
    @client.photographer_clients.create(photographer_id: current_photographer.id)
    redirect_to photographer_clients_path(current_photographer)
  end

  def edit
    @client = current_photographer.clients.find(params[:id])      
  end

  def update
    @client = current_photographer.clients.find(params[:id])  
    @client.update_attributes(editparams)
    
    if @client.save
      redirect_to photographer_clients_path(current_photographer)
    else
      render ('edit')
    end 
  end

  def client_events
    @path = session[:save_client]
    @client = Client.find(params[:id])
    @events = @client.events
    @event  = current_photographer.clients.find_by_id(params[:id]).events.new
    return render partial: "events", locals: { events: @events, event: @event, client: @client }
  end

  def search_clients
    clients = Client.where("email LIKE ?", "%#{params[:email]}%")
    return render partial: "search_clients", locals: { clients: clients }
  end

  def event 
    @event = Event.find_by_id(params[:id])
    return render partial: "event", locals: { event: @event }
  end

  def editparams
    params.require(:client).permit(:firstname,:lastname,:username,:email)
  end

  def clientsparams
    params.require(:client).permit(:firstname,:lastname,:username,:email,:password)  
  end

end

class ClientsController < ApplicationController

  def index
    @client = current_photographer.clients.all
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
        render :json => @client.to_json( :only =>[:id,:first_name,:last_name,:user_name,:email] )  
      else
        render json: {status: 'error'}
      end
    end
  end

  def new
    @client = current_photographer.clients.new 
  end

  def create
    @client = current_photographer.clients.new(clientsparams)
    if @client.save
      redirect_to photographer_client_path(current_photographer,@client.id)
    else
      flash[:notice] ="Error"
      render('new')
    end
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

  def event 
  end

  def editparams
    params.require(:client).permit(:first_name,:last_name,:user_name,:email)
  end

  def clientsparams
    params.require(:client).permit(:first_name,:last_name,:user_name,:email,:password)  
  end

end

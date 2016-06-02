class EventsController < ApplicationController
  before_filter :authenticate_photographer!
  
  def index
    @client = Client.find(params[:client_id])
    @event  = @client.events
  end

  def show
    @client = Client.find_by_id(params[:client_id]) 
    @event  = Event.find_by_id(params[:id])
  end

  def new
    @event = current_photographer.clients.find_by_id(params[:client_id]).events.new
  end

  def create
    @event = current_photographer.clients.find_by_id(params[:client_id]).events.new(event_params)
    if
      @event.save
      redirect_to photographer_client_path(current_photographer,params[:client_id])  
    else
      flash[:notice] ='Error'
      render('new')
    end
  end

  def upload_images
    param = { "image" => params[:file] }
    @image = current_photographer.clients.find_by_id(params[:client_id]).events.find_by_id(params[:id]).images.create(param)
  end

  def showevents
    @event =current_photographer.events.all
  end

  def all_images
    if current_photographer.present?
      @client = Client.find_by_id(params[:client_id])
      @event  = Event.find_by_id(params[:id])
      @image  = current_photographer.clients.find_by_id(params[:client_id]).events.find_by_id(params[:id]).images.all    
    else
      client_match_token
      if @client.present?  
        @image = @client.events.find_by_id(params[:event_id]).images.all.each do |img|
          @i = request.base_url + img.image_url
          img.update_attributes(url: @i) 
        end
        render :json => {status: "Ok" ,images: @image.as_json(:only => [:id, :event_id, :url, :is_liked ]) }  
      else
        render :json => { status: "error" }  
      end
    end
  end  

  def like
    if current_photographer.present?
      @image = Image.find_by_id(params[:image_id])
    else
      client_match_token
      if @client.present?
        @like = Image.find_by_id(params[:id]).update_attributes(is_liked: params[:is_liked])
        @like = Image.find_by_id(params[:id])
        render :json => { status: "Ok" ,like: @like.is_liked}
      else
        render :json => {status: "Error"}
      end 
    end
  end

  def image
    if current_photographer.present?
      @client =  Client.find_by_id(params[:client_id])
      @event  =  Event.find_by_id(params[:event_id])
      @image  =  Image.find_by_id(params[:image_id])
    else
      client_match_token
      @image = Image.find_by_id(params[:id])
      if @client.present?
        render :json =>  { status: "Ok", image: @image.as_json(:only =>[:id, :name, :event_id, :url] )  }
      else
        render :json => { status: 'error'}
      end
    end
  end
  
  protected 

  def event_params
    params.require(:event).permit(:name,:location,:bridal,:groom)
  end
end
 
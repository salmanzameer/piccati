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
    params[:event][:start_time] = DateTime.strptime(params[:event][:start_time], "%m/%d/%Y") 
    event = current_photographer.clients.find_by_id(params[:client_id]).events.create(event_params)
    @client = current_photographer.clients.find_by_id(params[:client_id])
    @events = @client.events
    @event  = event.client.events.new
    return render partial: "clients/events", locals: { events: @events, event: @event, client: @client }
  end

  def upload_images
    param = { "image" => params[:file] }
    @image = current_photographer.clients.find_by_id(params[:client_id]).events.find_by_id(params[:id]).images.new(param)
    @image.save
  end

  def showevents
    @event =current_photographer.events.all
  end

  def all_images
    @client = Client.find_by_id(params[:client_id])
    @event  = Event.find_by_id(params[:id])
    @image  = Image.where(imageable_id: params[:id])    
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
    params.require(:event).permit(:name, :location, :bridal, :groom, :start_time)
  end
end
 
class EventsController < ApplicationController
  before_filter :authenticate_photographer!
  before_filter :trial_expired?

  def scheduled_events
    start_of_day = params[:date].to_datetime.beginning_of_day
    end_of_day = params[:date].to_datetime.end_of_day
    @events = current_photographer.events.where("start_time >= ? and start_time <= ?", start_of_day, end_of_day)
    render partial: "secheduled_events", locals: { :@events => @events, :@date => params[:date] }
  end

  def index
    @client = Client.find(params[:client_id])
    @event  = @client.events.where(photographer_id: current_photographer.id)
  end

  def edit
    @event = Event.find(params["id"])
    render partial: "update_event_form", locals: { event: @event }
  end

  def update
    @event = Event.find(params["id"])
    event_params.each do |key, value|
      @event.assign_attributes(key => value)
    end

    @event.wedding? ? @event.save : @event.save(validate: false)
    render partial: "clients/event", locals: { event: @event }
  end

  def show
    @page_name = "Client Management"
    @clients = current_photographer.clients
    @current_client = @clients.first
    @off_clients = current_photographer.invite_clients
    @client = Client.new
    @event = @current_client.events.new if @current_client
  end

  def new
    @event = current_photographer.clients.find_by_id(params[:client_id]).events.new
  end

  def create
    create_event
    @events  = @client.events.where(photographer_id: current_photographer.id)
    @package = current_photographer.photographer_clients.where(client_id: @client.id, active: true).first
    return render partial: "clients/events", locals: { events: @events, client: @client }
  end

  def create_event
    @client  = Client.find(params[:client_id])
    event    = @client.events.new(event_params.merge!(photographer_id: current_photographer.id))
    event    = event.wedding? ? event.save : event.save(validate: false)
  end

  def create_calender_event
    start_of_day    = Date.today.to_datetime.beginning_of_day
    end_of_day      = Date.today.to_datetime.end_of_day
    @client         = Client.find(params[:event][:client_id])
    event           = @client.events.new(event_params.merge!(photographer_id: current_photographer.id))
    event           = event.wedding? ? event.save : event.save(validate: false)
    @calendar_event = current_photographer.events
    @events         = current_photographer.events.where("start_time >= ? and start_time <= ?", start_of_day, end_of_day)
    return render partial: "photographers/calender_and_info", locals: { calendar_event: @calendar_event, events: @events }
  end

  def upload_images
    client = current_photographer.clients.find_by_id(params[:client_id])
    @image = client.events.find_by_id(params[:id]).images.new(image: params[:file])
    if current_photographer.memory_available?(@image.image_file_size)
      client.update_attribute('enabled', true) if @image.save
    else
      flash[:notice] = 'You have not enough space.Please upgrade your plan.'
    end
    render js: "window.location = '#{all_images_photographer_client_event_path(current_photographer, client, params[:id])}';"
  end

  def upload_image
    @page_name = "Client Management"
    @client = Client.find_by_id(params[:client_id]) 
    @event  = Event.find_by_id(params[:id])
  end

  def showevents
    @event =current_photographer.events
  end

  def all_images
    @client = Client.find_by_id(params[:client_id])
    @event  = Event.find_by_id(params[:id])
    @images  = Image.where(imageable_id: params[:id], imageable_type: "Event")
    @page_name = "Client Management"
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
  
  def selected_images
    @page_name = "Client Management"
    @event = Event.find_by_id params[:id]
    respond_to do |format|
      format.html
      format.csv { send_data @event.to_csv }
    end
  end

  protected 

  def event_params
    params.require(:event).permit(:name, :location, :bridal, :groom, :start_time, :category_id, :description)
  end
end
 
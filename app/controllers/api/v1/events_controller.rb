class Api::V1::EventsController < ApplicationController

  def index
    @client = Client.find(params[:client_id])
    @event  = @client.events
    render :json => { status: 'Ok' ,events: @event,
      client: { id: @client.id ,name:  @client.first_name, username: @client.user_name, token: @client.authentication_token } } 
    end

    def show
      if current_photographer.present? 
        @client = Client.find_by_id(params[:client_id]) 
        @event  = Event.find_by_id(params[:id])
      else
        client_match_token
        @event  = @client.events.find_by_id(params[:id])
        if @client.present?

          render :json => { status: 'Ok' ,event: @client.events.find_by_id(params[:id]) }
        else
          render :json => { status: 'Error'}
        end
      end
    end

    def new
      @client =current_photographer.clients.find_by_id(params[:client_id]) 
      @event = current_photographer.clients.find_by_id(params[:client_id]).events.new
    end

    def create
      @event = current_photographer.clients.find_by_id(params[:client_id]).events.new(eventparams)
      if
       @event.save
       @event.images.create(params.require(:event).permit(:image)) 
       redirect_to  api_v1_photographer_client_path(current_photographer,params[:client_id])  
     else
      flash[:notice] ='Error'
      render('new')
    end
  end

  def eventparams
   params.require(:event).permit(:name,:location,:bridal,:groom)
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
    render :json => {status: "Ok" ,images: @image.as_json(:only => [:id, :event_id, :url]) }  
  else
    render :json => { status: "error" }  
  end
end
end  

def like
#binding.pry
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
end
 # render :json => {event: @event }
          # @client ==  current_photographer.clients.find_by_id(params[:client_id])
            # @event1= Event.new
               #@event = @image.images.find_by_id(params[:id])
                  #@image = upload_photographer_client_event_path(current_photographer.id,@client.id,@event.id).images.find_by_id(params[:id])
  #                   @menu = {"menu" => @client.events , "data" => {"name" => @event.name, "location" => @event.location, "Bridal" => @event.bridal , "image_url" => @event.images }  }
  #                      respond_to do |format|
  #                        format.json {render :json => @menu.to_json}
  #                          end


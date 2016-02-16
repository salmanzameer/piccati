class Api::V1::EventsController < ApplicationController

  def index
    @client = Client.find(params[:client_id])
    @event  = @client.events
    render :json => {events: @event,
    client: {name:  @client.first_name, username: @client.user_name, token: @client.authentication_token } } 
  end

  def show

    if current_photographer.present? 
      @client = Client.find_by_id(params[:client_id]) 
      @event  = Event.find_by_id(params[:id])
    else
      client_match_token
      @event  = @client.events.find_by_id(params[:id])
      if @client.present?

        render :json => { event: @client.events.find_by_id(params[:id]) }
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
 # binding.pry
  params.require(:event).permit(:name,:location,:bridal,:groom)
end

def upload_images
      #@client = Client.find_by_id(params[:client_id])
      param = { "image" => params[:file] }
      @image = current_photographer.clients.find_by_id(params[:client_id]).events.find_by_id(params[:id]).images.create(param)

    end

    def showevents
      @event =current_photographer.events.all
             
    end

    def all_images
      
      if current_photographer.present?
       @client = Client.find_by_id(params[:client_id])
       @event = Event.find_by_id(params[:id])
       @image = current_photographer.clients.find_by_id(params[:client_id]).events.find_by_id(params[:id]).images.all    
     else
      client_match_token


      if @client.present?  

        render :json => { images:  @client.events.find_by_id(params[:event_id]).images.all  }  
      else

        render :json => { error: "error" }  
       end
     end
   end  

  def image
     
    if current_photographer.present?
       @client = Client.find_by_id(params[:client_id])
       @event = Event.find_by_id(params[:event_id])
       @image = Image.find_by_id(params[:image_id])  
    else
      client_match_token
      @image = Image.find_by_id(params[:id]) 
      if @client.present?
        render :json => { image: @image   }

      else
        render :json => { status: 'error'}
      end
    end
    

    #render :json => { image:   @image }

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


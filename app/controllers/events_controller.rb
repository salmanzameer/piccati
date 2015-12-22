class EventsController < ApplicationController
  def index
    #@event = Event.all
    @event = current_photographer.clients.find_by_id(params[:client_id]).events.all
  end

  def show
      @event = current_photographer.clients.find_by_id(params[:client_id]).events
      
  end

  def new
   #  @photographer
   # @client
     @event = current_photographer.clients.find_by_id(params[:client_id]).events.new
   # @event = @client.build_event
  end

  def create
      @event = current_photographer.clients.find_by_id(params[:client_id]).events.new(eventparams)
    if @event.save
        @event.images.create(params.require(:event).permit(:image)) 
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
  end

  def delete
  end

  def eventparams
    params.require(:event).permit(:name)
  end
# def upload_images
# end

# def upload
#   @event = current_photographer.clients_find_by_id(params[:client_id]).events_find_by_id(params[:event_id]).Image.new(:image)
  
#   end

  # def to_hash  
  #   hash = {}    
  #   instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }    
  #   hash    
  # end
end

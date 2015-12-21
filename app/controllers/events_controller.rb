class EventsController < ApplicationController
  def index
    @event = Event.all
    #@event = current_photographer.clients.find_by_id(params[:client_id]).events.all
  end

  def show
      @event = current_photographer.clients.find_by_id(params[:id])
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
    params.require(:event).permit(:name,:attachment,:image)
  end
end

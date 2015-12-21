class ClientsController < ApplicationController
  def index
   #@client =Client.sorted
   #binding.pry
   @client = current_photographer.clients.all
  end
    def show
     @client =current_photographer.clients.find(params[:id])
    end

  def new
         @client = current_photographer.clients.new 
  end

  def create
  
   @client = Client.new(clientsparams)
     @client = current_photographer.clients.new(clientsparams)
        if @client.save
          redirect_to :action => 'show1', :photographer_id => current_photographer.id, :client_id => @client.id
         else
           flash[:notice] ="Error"
            render('new')
    end
      end
      def show1
        @client =current_photographer.clients.find(params[:client_id])
      end
    def edit
      @client = current_photographer.clients.find(params[:id])      
     end
     def update
       @client = current_photographer.clients.find(params[:id])  
       @client.update_attributes(clientsparams)
       if @client.save
          redirect_to(:action => 'index')
        else
          render('new')
        end 
     end

   # def delete
   #   @client = current_photographer.clients.find(params[:id])
   #  end
   #  def destroy
   #    client = current_photographer.clients.find(params[:id])
   #    client.destroy
   #    redirect_to(:action => 'index')
   #  end

   def clientsparams
   
    params.require(:client).permit(:first_name,:last_name,:user_name,:email,:password)  
   
     end

end

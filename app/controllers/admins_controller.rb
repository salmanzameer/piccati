class AdminsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def new
  	@admin = Admin.new
  end

  def create
  	@admin = Admin.new(admin_param)
  end

  def dashboard
    @clients = Client.count
    @photographers = Photographer.count
  end

  def destroy_plan
    @plan = Plan.find(params[:plan_id]).destroy
    redirect_to admin_plans_path  
  end

  def plans
    @plans = Plan.all.order(created_at: 'DESC').paginate(:page => params[:page], :per_page => 10)    
    respond_to do |f|
      f.js
    end
  end

  def new_plan
    @plan = Plan.new(plan_params)
    respond_to do |f|
      f.js
    end
  end

  def edit_plan
    @plan = Plan.find(params[:plan_id])
  end

  def update_plan
    @plan = Plan.find(params[:plan][:plan_id])
    @plan.update_attributes(name: params[:plan][:name], storage: params[:plan][:storage], connects: params[:plan][:connects])
    redirect_to admins_show_all_plans_path
  end

  def create_plan
    Plan.create(name: params[:plan][:name],storage: params[:plan][:storage], connects: params[:plan][:connects])
    redirect_to admin_plans_path
  end

  def change_status
    photographer_plan = PhotographerPlan.find(params[:p_plan_id])
    if photographer_plan.pending?
      photographer_plan.update(status: PhotographerPlan::Status::ACTIVE)
      photographer_plan.photographer.update(expired_at: DateTime.now + 1.year)
    else
      photographer_plan.update(status: PhotographerPlan::Status::EXPIRED)
    end
    
    redirect_to photographer_plans_path  
  end

  def photographer_plans
    @photographerPlans = PhotographerPlan.all.order(created_at: 'DESC').paginate(:page => params[:page], :per_page => 10)
    respond_to do |f|
      f.js
    end
  end

  def update_all_images
    @album = Album.find(params[:album][:album_id])
    # @album.images.paginate(:page => params[:page], :per_page => 8)
    if @album.update(image_param)
      respond_to do |f|
        f.js {  flash[:notice] = "Approved Successfully" }
      end
    end
  end

  def album_images
    album_id = params[:album_id]
    @album = Album.find(album_id)
    # @album.images.paginate(:page => params[:page], :per_page => 8)
    respond_to do |f|
      f.js
    end
  end

  def albums
    @albums = Album.all.order(created_at: 'DESC').paginate(:page => params[:page], :per_page => 10)
    respond_to do |f|
      f.js
    end
  end

  def clients
    if request.xhr?
      #binding.pry
      if params[:client_type] == "Connected"
        @clients = Client.includes(:photographer_clients).where( photographer_clients: {is_connected: true} ).order(created_at: 'DESC').paginate(:page => params[:page], :per_page => 10)
      elsif params[:client_type] == "Not Connected"
        @clients = Client.includes(:photographer_clients).where( photographer_clients: {is_connected: false} ).order(created_at: 'DESC').paginate(:page => params[:page], :per_page => 10)
      end
    else
      @clients = Client.all.order(created_at: 'DESC').order(created_at: 'DESC').paginate(:page => params[:page], :per_page => 10)    
    end
    respond_to do |f|
      f.js
    end 
  end

  def photographers 
    # if request.xhr?
    #   binding.pry
    #   @photographers = Photographer.all.where(plan_type: params[:plan_type]).order(created_at: 'DESC').paginate(:page => params[:page], :per_page => 10)    
    # else
    #   binding.pry
    #   @photographers = Photographer.all.order(created_at: 'DESC').order(created_at: 'DESC').paginate(:page => params[:page], :per_page => 10)
    # end
    # binding.pry
    @photographers = Photographer.all.order(created_at: 'DESC').order(created_at: 'DESC').paginate(:page => params[:page], :per_page => 10)
    respond_to do |f|
      f.js
    end
  end

  private 

    def admin_param
    	params.require(:admin).permit(:email, :password)
    end

    def image_param
      params.require(:album).permit(images_attributes: [:status, :id])
    end

    def plan_params
      #params.require(:plan).permit(:name, :connects, :storage)
    end

end

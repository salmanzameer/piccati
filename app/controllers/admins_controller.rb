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
  end

  def destroy_plan
    @plan = Plan.find(params[:plan_id]).destroy
    redirect_to admins_show_all_plans_path  
  end

  def show_all_plans
    @plans = Plan.all.order(created_at: 'DESC')    
  end

  def new_plan
    @plan = Plan.new(plan_params)
  end

  def create_plan
    Plan.create(name: params[:plan][:name],storage: params[:plan][:storage], connects: params[:plan][:connects])
    redirect_to admins_show_all_photographers_path
  end

  def change_status
    @p_plan = PhotographerPlan.find(params[:p_plan_id])
    # Pending => 2
    # Active => 1
    # Expired => 0
    if @p_plan.status == "2"
      @p_plan.update(status: "1")
    elsif @p_plan.status == "1"
      @p_plan.update(status: "2")
    else
      @p_plan.update(status: "2")
    end
    redirect_to admins_show_all_photographers_path  
  end

  def show_all_photographer_plans
    @photographerPlan = PhotographerPlan.all.order(created_at: 'DESC')
  end

  def show_all_photographers
    if request.xhr?
      if params[:confirmed] == "true"
        @photographers = Photographer.where.not(confirmed_at: nil).order(created_at: 'DESC')
      elsif params[:confirmed] == 'false'
        @photographers = Photographer.where(confirmed_at: nil).order(created_at: 'DESC')        
      end
    else
      @photographers = Photographer.all.order(created_at: 'DESC')      
    end
  end

  def update_all_images
    album = Album.find(params[:album][:album_id])
    if album.update(image_param)
      redirect_to admins_show_all_albums_path
    end
  end

  def album_images
    album_id = params[:album_id]
    @album = Album.find(album_id)
    # @album_images = Album.find(album_id).images.order(created_at: 'DESC')
  end

  def show_all_albums
    @albums = Album.all.order(created_at: 'DESC')
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

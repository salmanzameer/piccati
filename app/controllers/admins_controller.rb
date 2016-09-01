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
    if @p_plan.status == "pending"
      @p_plan.update(status: "active")
    elsif @p_plan.status == "active"
      @p_plan.update(status: "pending")
    end
    redirect_to admins_show_all_photographers_path  
  end

  def show_all_photographers
    @photographerPlan = PhotographerPlan.all.order(created_at: 'DESC')
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

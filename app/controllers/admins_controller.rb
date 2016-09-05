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
    photographer_plan = PhotographerPlan.find(params[:p_plan_id])
    if photographer_plan.pending?
      photographer_plan.update(status: PhotographerPlan::Status::ACTIVE)
      photographer_plan.photographer.update(expired_at: DateTime.now + 1.year)
    else
      photographer_plan.update(status: PhotographerPlan::Status::EXPIRED)
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

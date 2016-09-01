class AdminsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def new
  	@admin = Admin.new
  end

  def create
    binding.pry
  	@admin = Admin.new(admin_param)
  end

  def dashboard
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
end

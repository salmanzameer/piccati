class AlbumsController < ApplicationController
  before_filter :authenticate_photographer!
  before_filter :trial_expired?
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = current_photographer.albums
    @page_name = "My Albums"
  end

  def show
    @page_name = "My Albums"
  end

  def new
    @album = Album.new
  end

  def edit
  end

  def create
    @album = current_photographer.albums.create(album_params)
    @album.create_activity(key: "shared an album #{@album.name}", owner: current_photographer)
    redirect_to photographer_albums_path
  end

  def update
    @album.update(album_params)
    @album.create_activity(key: "updated an album #{@album.name}", owner: current_photographer)
    redirect_to photographer_album_path
  end

  def destroy
    @album.create_activity(key: "deleted an album", owner: current_photographer)
    @album.destroy
    respond_to do |format|
      format.html { redirect_to photographer_albums_path, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def public_image
    @page_name = "My Albums"
    @album = Album.find(params[:album_id])
    @image = @album.images.new(image: params[:file])
    if current_photographer.memory_available?(@image.image_file_size) && @image.save
      @image.create_activity(key: "added an image to album #{@album.name}", owner: current_photographer)
    else
      flash[:notice] = 'You have not enough space.Please upgrade your plan.'
    end
      render js: "window.location = '#{photographer_album_public_image_path(current_photographer.id, @album.id)}';"
  end

  def image_destroy
    @image = Image.find(params[:image_id])
    current_photographer.memory_refactor(@image.image_file_size)
    @image.destroy
    redirect_to photographer_album_path(photographer_id: params[:photographer_id], id: params[:id])
  end

  def untitled_album
    @album = current_photographer.albums.find_or_create_by(name:"Untitled")
    respond_to do |format|
      format.js
    end
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name, :photographer_id, :description, image_attributes: [:image])
    end
end

class AlbumsController < ApplicationController
  before_filter :authenticate_photographer!
   before_filter :trial_expired?
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = current_photographer.albums
    @page_name = "My Albums"
  end

  def show
  end

  def new
    @album = Album.new
  end

  def edit
  end

  def create
    @album = current_photographer.albums.create(album_params)
    @album.create_activity(key: "create a album", owner: current_photographer)
    redirect_to photographer_albums_path
  end

  def update
    @album.update(album_params)
    @album.create_activity(key: "update a album", owner: current_photographer)
    redirect_to photographer_album_path
  end

  def destroy
    @album.destroy
    @album.create_activity(key: "delete a album", owner: current_photographer)
    respond_to do |format|
      format.html { redirect_to photographer_albums_path, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def public_image
    @page_name = "My Albums"
    @album = Album.find(params[:album_id])
    @album.images.create(image: params[:file])     
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name, :photographer_id, :description, image_attributes: [:image])
    end
end

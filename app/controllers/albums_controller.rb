class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
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
    redirect_to photographer_albums_path
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to photographer_albums_path, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def public_image
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

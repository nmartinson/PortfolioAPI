class Api::V1::GalleryPhotosController < Api::V1::ApplicationController

  def show
    puts 'show'
    @galleries = GalleryPhoto.where(photo_id: params[:id])
        # @photos = Photo.includes(:settings, :tags).where(id: params[:id]).first
    render json: @galleries
  end

  def index
    puts 'index'
    setting = PhotoSetting.where(photo_id: params[:id])
    if setting
      render json: setting, status: 200
    else
      render json: {error: 'shits busted'}, status: 400
    end
  end
end
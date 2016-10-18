class Api::V1::GalleryController < Api::V1::ApplicationController

  def index
    @photos = Photo.includes(:settings).where(gallery_id: params[:gallery_id])
    render json: @photos.as_json({include: {settings:{}}})
  end

end
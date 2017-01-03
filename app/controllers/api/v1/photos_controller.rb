class Api::V1::PhotosController < Api::V1::ApplicationController

  def index
    @photoset = Photo.all
    render json: @photoset
  end

  def show
    @photos = Photo.includes(:settings, :tags).where(id: params[:id]).first
    render json: @photos.as_json({include: {settings:{}, tags:{}}})
  end

  def update
    if params[:image].present?
      image = params[:image]
      currentPhoto = Photo.where(id: image[:photo_id]).first_or_initialize
      currentPhoto.name = image["name"]
      currentPhoto.description = image["description"]
      currentPhoto.order = image["order"]
      currentPhoto.save

      PhotoSetting.where(photo_id: image[:photo_id]).destroy_all

      if image[:settings].nil? == false
        image[:settings].each do |setting|
          currentPhotoSetting = PhotoSetting.where(photo_id: image[:photo_id], setting_id: setting["id"]).first_or_initialize
          currentPhotoSetting.photo_id = currentPhoto["id"]
          currentPhotoSetting.setting_id = setting["id"]
          currentPhotoSetting.save
        end
      end
    end
   render plain: "Update success"
  end
end
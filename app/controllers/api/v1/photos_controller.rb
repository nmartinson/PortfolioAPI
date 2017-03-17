class Api::V1::PhotosController < Api::V1::ApplicationController
  THUMB_URL = "http://www.boundless-journey.com/portfolio/images/thumbnails/"

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



def create
    uniqueNames = []
    params[:images].each do |image|
      if image[:file] && image[:uniqueFileName]
        Dir.mkdir('public/photos/') unless File.exists?('public/photos/')

        jpg = Base64.decode64(image[:file]['data:image/jpg;base64,'.length .. -1])

        metadata = image[:imageData]
        if metadata.blank?
          thumbnail_url = THUMB_URL + image[:uniqueFileName].chomp(".jpg") + "_thumb.jpg"
          @photo = Photo.create(name: image[:name], description: image[:description], protected: image[:protected], url: "http://www.boundless-journey.com/portfolio/images/" + image[:uniqueFileName], thumbnail_url: thumbnail_url, is_featured: true)
        else
          if metadata[:date].present?
            date = metadata[:date].gsub(":", "-")
          else
            date = nil
          end
          if metadata[:gps].present?
            lat = metadata[:gps][:Lat]
            long = metadata[:gps][:Long]
          else
            lat = nil
            long = nil
          end
          thumbnail_url = THUMB_URL + image[:uniqueFileName].chomp(".jpg") + "_thumb.jpg"
          @photo = Photo.create(lens: metadata[:lens], gps_lat: lat, gps_long: long, date: date, copyright: metadata[:copyright], fstop: metadata[:fstop], exposure_time: metadata[:exposureTime], focal_length: metadata[:focalLength], iso: metadata[:iso], make: metadata[:make], model: metadata[:model], name: image[:name], description: image[:description], protected: image[:protected], url: "http://www.boundless-journey.com/portfolio/images/features/" + image[:uniqueFileName], thumbnail_url: thumbnail_url, is_featured: true)
          if metadata[:tags].present?
            metadata[:tags].each do |tag|
              Tag.create(tag: tag, photo_id: @photo.id)
            end
          end
        end

        
        uniqueNames << image[:uniqueFileName] 
      end
    end

    params[:images].each do |image|
      if image[:settings].present?
        image[:settings].each do |setting|
          Setting.create(size: setting[:size], price: setting[:price], medium: setting[:medium], photo_id: @photo.id)
        end
      end
    end

    #Add galleries
    params[:images].each do |image|
      if image[:galleries].present?
        params[:galleries].each do |gallery|
          GalleryPhoto.create(photo_id: @Photo, gallery_id: gallery.id)
        end
      end
    end

   render plain: uniqueNames
  end



end
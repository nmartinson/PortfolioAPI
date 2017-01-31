class Api::V1::FeaturesController < Api::V1::ApplicationController

  def index
    photos = Photo.includes(photo_settings: :setting).featured
    render json: photos.order(order: :asc).as_json({include: {settings:{}}})
  end

  def create
    uniqueNames = []
    params[:images].each do |image|
      if image[:file] && image[:uniqueFileName]
        Dir.mkdir('public/Features/') unless File.exists?('public/Features/')

        jpg = Base64.decode64(image[:file]['data:image/jpg;base64,'.length .. -1])

        metadata = image[:imageData]
        if metadata.blank?
          thumbnail_url = "http://www.boundless-journey.com/portfolio/images/features/thumbnails/" + image[:uniqueFileName].chomp(".jpg") + "_thumb.jpg"
          @photo = Photo.create(name: image[:name], description: image[:description], protected: image[:protected], url: "http://www.boundless-journey.com/portfolio/images/features/" + image[:uniqueFileName], thumbnail_url: thumbnail_url, is_featured: true)
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
          thumbnail_url = "http://www.boundless-journey.com/portfolio/images/features/thumbnails/" + image[:uniqueFileName].chomp(".jpg") + "_thumb.jpg"
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

   render plain: uniqueNames
  end
end
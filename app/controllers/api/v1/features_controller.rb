class Api::V1::FeaturesController < Api::V1::ApplicationController

  def show
    @photos = Photo.where(is_featured: true)
    render json: @photos.as_json({include: {settings:{}}})
  end

  def create
    uniqueNames = []
    params[:images].each do |image|
      if image[:file] && image[:uniqueFileName]
        Dir.mkdir('public/Features/') unless File.exists?('public/Features/')

        jpg = Base64.decode64(image[:file]['data:image/jpg;base64,'.length .. -1])
        # directory = "public/Features"
        # path = File.join(directory, image[:uniqueFileName])
        # File.open(path, "wb") { |f| f.write(jpg) }

        metadata = image[:imageData]
        if metadata.blank?
          @photo = Photo.create(name: image[:name], description: image[:description], protected: image[:protected], url: "http://www.boundless-journey.com/portfolio/images/features/" + image[:uniqueFileName], is_featured: true)
        else
          date = metadata[:date].gsub(":", "-")
          puts metadata[:tags]
          @photo = Photo.create(date: date, copyright: metadata[:copyright], fstop: metadata[:fstop], exposure_time: metadata[:exposureTime], focal_length: metadata[:focalLength], iso: metadata[:iso], make: metadata[:make], model: metadata[:model], name: image[:name], description: image[:description], protected: image[:protected], url: "http://www.boundless-journey.com/portfolio/images/features/" + image[:uniqueFileName], is_featured: true)
          if metadata[:tags].present?
            puts 'exist'
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
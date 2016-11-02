class Api::V1::FeaturesController < Api::V1::ApplicationController

  def show
    @photos = Photo.where(is_featured: true)
    render json: @photos.as_json({include: {settings:{}}})
  end

  def create
    uniqueNames = []
    params[:images].each do |image|
      if image[:file] && image[:uniqueFileName]
        # Dir.mkdir('public/Features/') unless File.exists?('public/Features/')

        # jpg = Base64.decode64(image[:file]['data:image/jpg;base64,'.length .. -1])
        # directory = "public/Features"
        # path = File.join(directory, image[:uniqueFileName])
        # File.open(path, "wb") { |f| f.write(jpg) }

        # size = FastImage.size(path)
        is_landscape = false #size[0] > size[1] # width > height
        @photo = Photo.create(name: image[:name], description: image[:description], is_landscape: is_landscape, protected: image[:protected], url: "http://localhost:3000/Features/" + image[:uniqueFileName], is_featured: true)
        uniqueNames << image[:uniqueFileName] 
      end
    end

    params[:images].each do |image|
      if image[:settings].present?
        image[:settings].each do |setting|
          Setting.create(size: setting[:size], price: setting[:price], photo_id: @photo.id)
        end
      end
    end

   render plain: uniqueNames
  end
end
class Api::V1::GalleryController < Api::V1::ApplicationController

  def index
    @photos = Photo.includes(:settings).where(gallery_id: params[:gallery_id])
    render json: @photos.as_json({include: {settings:{}}})
  end

  def create
    exists = Gallery.exists?(name: params[:galleryName])
    if !exists
      if params[:galleryName]
        Dir.mkdir('public/Galleries/' +params[:galleryName]) unless File.exists?('public/Galleries/' +params[:galleryName])
        cover = params[:cover_image]
        if(params[:cover_image].present? == false)
          cover = "http://localhost:3000/assets/Galleries/Olympic/DSC_6485-347f5ed8bac3ab0620cf81bf1486712a745c2a2d650dbe95c9b84d444bd5a7e3.jpg"
        end
        @gallery = Gallery.create(name: params[:galleryName], description: params[:description], protected: false, cover_image: cover, cover_is_landscape: true)
      end
    else
      @gallery = Gallery.where(name: params[:galleryName]).first
    end

    uniqueNames = []
    params[:images].each do |image|
      if image[:file] && image[:uniqueFileName]
        jpg = Base64.decode64(image[:file]['data:image/jpg;base64,'.length .. -1])
        directory = "public/Galleries/" + params[:galleryName]
        path = File.join(directory, image[:uniqueFileName])
        File.open(path, "wb") { |f| f.write(jpg) }

        size = FastImage.size(path)
        is_landscape = size[0] > size[1] # width > height
        @photo = Photo.create(name: image[:name], description: image[:description], is_landscape: is_landscape, protected: image[:protected], url: "http://localhost:3000/Galleries/" + params[:galleryName] + "/" + image[:uniqueFileName], gallery_id: @gallery.id, is_featured: image[:isFeatured])
        uniqueNames << image[:uniqueFileName] 
      end
      if image[:isFeatured].present? == true
        @gallery.update(cover_image: @photo.url, cover_is_landscape: is_landscape)
      else
        puts 'not featured'
      end
    end

    params[:images].each do |image|
      image[:settings].each do |setting|
        Setting.create(size: setting[:size], price: setting[:price], photo_id: @photo.id)
      end
    end

   render plain: uniqueNames
  end

end
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
    puts 'update'
    puts params
    if params[:image].present?
      image = params[:image]
      Photo.where(:id => image[:photo_id]).update_all(name: image[:name], description: image[:description], order: image[:order])
      if image[:settings].present?
        image[:settings].each do |setting|
          if setting[:id].present?
            Setting.where(:id => setting[:id]).update_all(size: setting[:size], price: setting[:price], medium: setting[:medium])
          elsif
            Setting.create(size: setting[:size], price: setting[:price], photo_id: image[:photo_id], medium: setting[:medium]) 
          end
        end
      end
    end
       render plain: "Update success"
  end
end
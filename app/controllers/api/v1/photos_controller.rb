class Api::V1::PhotosController < Api::V1::ApplicationController

  def index
    @photoset = Photo.all
    render json: @photoset
  end

  def update
    puts params
    if params[:image].present?
      image = params[:image]
      Photo.where(:id => image[:photo_id]).update_all(name: image[:name], description: image[:description])
      if image[:settings].present?
        image[:settings].each do |setting|
          if setting[:id].present?
            Setting.where(:id => setting[:id]).update_all(size: setting[:size], price: setting[:price])
          elsif
            Setting.create(size: setting[:size], price: setting[:price], photo_id: image[:photo_id]) 
          end
        end
      end
    end
       render plain: "Update success"
  end
end
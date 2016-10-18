class Api::V1::PhotosController < Api::V1::ApplicationController

  def index
    @photoset = Photo.all
    render json: @photoset
  end
end
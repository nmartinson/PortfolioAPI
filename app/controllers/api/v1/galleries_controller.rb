class Api::V1::GalleriesController < Api::V1::ApplicationController

  def index
    @galleries = Gallery.all
    render json: @galleries
  end

end
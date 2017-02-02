class Api::V1::MediumsController < Api::V1::ApplicationController

  def index
    @medium = Medium.uniq.pluck(:value)
        # @photos = Photo.includes(:settings, :tags).where(id: params[:id]).first
    render json: @medium
  end

end
class Api::V1::PhotoSettingsController < Api::V1::ApplicationController

  def show
    @photo_setting = PhotoSetting.includes(:settings).where.not(photo_id: params[:photo_id])
        # @photos = Photo.includes(:settings, :tags).where(id: params[:id]).first
    render json: @photo_setting
  end

  def index
    setting = PhotoSetting.where(photo_id: params[:id])
    if setting
      render json: setting, status: 200
    else
      render json: {error: 'shits busted'}, status: 400
    end
  end
end
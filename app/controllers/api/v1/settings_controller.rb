class Api::V1::SettingsController < Api::V1::ApplicationController

  def index
    @setting = Setting.all
    render json: @setting
  end

def show
	setting = Setting.where(photo_id: params[:photo_id])
	if setting
	  render json: setting, status: 200
	else
	  render json: {error: 'shits busted'}, status: 400
	end
end
end
class Api::V1::SettingsController < Api::V1::ApplicationController

  def show
    @settings = Setting.all
    render json: @settings
  end

  def available_settings
    ps_setting_ids = PhotoSetting.where(photo_id: params[:photo_id]).pluck(:setting_id)
    settings = Setting.where.not(id: ps_setting_ids)

    render json: settings
  end

  def update
    params[:settings].each do |setting|
      currentSetting = Setting.where(id: setting[:id]).first_or_initialize
      currentSetting.size = setting["size"]
      currentSetting.price = setting["price"]
      currentSetting.medium = setting["medium"]
      currentSetting.dealer = setting["dealer"]
      currentSetting.dealer_cost = setting["dealer_cost"]
      currentSetting.has_free_shipping = setting["has_free_shipping"]
      currentSetting.save
    end
    render plain: "Success"
  end

  def index
  	settings = Setting.all
  	if settings
  	  render json: settings, status: 200
  	else
  	  render json: {error: 'shits busted'}, status: 400
  	end
  end
end
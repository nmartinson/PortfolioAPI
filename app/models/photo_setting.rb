class PhotoSetting < ActiveRecord::Base
    belongs_to :photo
    belongs_to :setting
end

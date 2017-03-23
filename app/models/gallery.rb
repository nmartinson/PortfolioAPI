class Gallery < ActiveRecord::Base
	has_many :photos, through: :gallery_photos
	has_many :gallery_photos
end

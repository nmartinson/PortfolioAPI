class GalleryPhoto < ActiveRecord::Base
	belongs_to :gallery
	belongs_to :photo
end

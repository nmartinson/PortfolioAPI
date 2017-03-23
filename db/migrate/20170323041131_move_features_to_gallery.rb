class MoveFeaturesToGallery < ActiveRecord::Migration
  def self.up
  	Gallery.where(name: "Featured").destroy_all
  	gallery = Gallery.where(name: "Featured", description: "Featured Photos", protected: false).first_or_initialize
  	gallery.save
    Photo.find_each do |photo|
      galleryPhoto = GalleryPhoto.where(photo_id: photo.id, gallery_id: gallery.id).first_or_initialize
      galleryPhoto.photo_id = photo.id
      galleryPhoto.save
	end
  end
end

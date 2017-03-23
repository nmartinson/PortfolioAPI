class GalleryPhotos < ActiveRecord::Migration
  def change
    create_table :gallery_photos do |t|
      t.belongs_to :gallery, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true
      t.timestamps null: false
  	end
  end
end

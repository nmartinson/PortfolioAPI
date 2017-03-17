class CreateGalleriesPhotos < ActiveRecord::Migration
  def change
    create_table :galleries_photos do |t|
      t.integer :photo_id
      t.integer :gallery_id
      t.belongs_to :gallery, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

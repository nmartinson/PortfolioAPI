class CreatePhotoSettings < ActiveRecord::Migration
  def change
    create_table :photo_settings do |t|
      t.integer :photo_id
      t.timestamps null: false
      t.belongs_to :photo, index: true, foreign_key: true
      t.references :setting, index: true, foreign_key: true

    end
  end
end

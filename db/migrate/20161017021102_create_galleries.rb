class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.string :description
      t.boolean :protected
      t.string :cover_image
      t.datetime :created

      t.timestamps null: false
    end
  end
end

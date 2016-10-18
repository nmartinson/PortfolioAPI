class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.string :description
      t.boolean :protected
      t.string :url
      t.datetime :created
      t.belongs_to :gallery, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

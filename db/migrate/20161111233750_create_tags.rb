class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :photo_id
      t.string :tag
      t.belongs_to :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

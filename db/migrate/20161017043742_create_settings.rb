class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :size
      t.float :price
      t.belongs_to :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

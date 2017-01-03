class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :size
      t.float :price
      t.timestamps null: false
    end
  end
end

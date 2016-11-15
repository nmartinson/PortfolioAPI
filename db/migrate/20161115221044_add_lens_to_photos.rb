class AddLensToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :lens, :string
  end
end

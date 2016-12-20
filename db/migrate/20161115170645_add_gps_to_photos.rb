class AddGpsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :gps_lat, :float
    add_column :photos, :gps_long, :float
  end
end

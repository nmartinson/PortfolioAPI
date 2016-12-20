class AddAttributesToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :copyright, :string
    add_column :photos, :exposure_time, :string
    add_column :photos, :fstop, :float
    add_column :photos, :focal_length, :string
    add_column :photos, :iso, :integer
    add_column :photos, :make, :string
    add_column :photos, :model, :string
    add_column :photos, :date, :datetime
  end
end

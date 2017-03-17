class ChangeCoverTypeInGallery < ActiveRecord::Migration
  def up
    add_column :galleries, :cover_photo_id, :integer
  end

  def down
    remove_column :galleries, :cover, :string
  end
end

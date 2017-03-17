class AddJoinToGallery < ActiveRecord::Migration
  def change
	add_reference :galleries, :photo, index: true
  end
end

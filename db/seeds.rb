# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'


# Dir.foreach("app/assets/images/Galleries") do |item|
Dir.foreach("public/assets/Galleries") do |item|
  next if ['.', '..', '.DS_Store'].include?(item)
  puts item
  gallery = Gallery.create(name: item, description: 'Gallery Description', cover_image: "http://localhost:3000/assets/Galleries/Olympic/DSC_6485-347f5ed8bac3ab0620cf81bf1486712a745c2a2d650dbe95c9b84d444bd5a7e3.jpg")
  Dir.foreach("app/assets/images/Galleries/" + item) do |innerItem|
  	next if ['.', '..', '.DS_Store'].include?(innerItem)
	photo = Photo.create(name: "Image Name", description: "Image Description", url: "http://localhost:3000/assets/Galleries/" + innerItem, gallery_id: gallery.id)
  settings = Setting.create(photo_id: photo.id, size: "10x20in", price: 100.00)
  settings = Setting.create(photo_id: photo.id, size: "20x30in", price: 160.00)


  end
  # JSON.parse(open("../app/assets/" + item).read).each do |stuff|
  #   Gallery.create(stuff)
  # end
end
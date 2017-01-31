class UpdatePhotoThumbnailUrlsAddFolder < ActiveRecord::Migration
def self.up    
  say_with_time "Updating foos..." do
    Photo.find_each do |f|
      if(f.url != nil)
        thumburl = f.url.chomp('.jpg') + "_thumb.jpg"
        f.thumbnail_url = thumburl
      end
      if(f.thumbnail_url != nil)
        index = f.thumbnail_url.index('features/') + 'features/'.length
        thumburl = f.thumbnail_url.insert(index, "thumbnails/")
        puts thumburl
        f.thumbnail_url = thumburl
        f.save!
      end
    end
  end
end
end

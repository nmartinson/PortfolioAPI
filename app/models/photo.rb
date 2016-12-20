class Photo < ActiveRecord::Base
	has_many :settings
  has_many :tags
end

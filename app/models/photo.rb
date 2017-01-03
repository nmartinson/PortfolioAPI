class Photo < ActiveRecord::Base
  has_many :photo_settings
  has_many :tags
  has_many :settings, through: :photo_settings

  scope :featured, -> {where(is_featured: true)}
end

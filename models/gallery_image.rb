class GalleryImage < ActiveRecord::Base
  mount_uploader :image, GalleryImageUploader
  validates :image, presence: true
end

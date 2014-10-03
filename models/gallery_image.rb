class GalleryImage < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  validates :image, presence: true
end

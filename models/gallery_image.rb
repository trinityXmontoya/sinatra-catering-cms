class GalleryImage < ActiveRecord::Base
  validates :url, presence: true
end

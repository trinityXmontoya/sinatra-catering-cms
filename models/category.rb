class Category < ActiveRecord::Base
  mount_uploader :image, CategoryImageUploader
  has_many :menu_items
  validates :name, presence: true, uniqueness: true
end

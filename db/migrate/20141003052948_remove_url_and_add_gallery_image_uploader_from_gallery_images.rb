class RemoveUrlAndAddGalleryImageUploaderFromGalleryImages < ActiveRecord::Migration
  def change
    remove_column :gallery_images, :url, :string
    add_column :gallery_images, :image, :string
  end
end

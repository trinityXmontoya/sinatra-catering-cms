class GalleryImageUploader < CarrierWave::Uploader::Base
  storage :fog

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    'gallery_images'
  end
end

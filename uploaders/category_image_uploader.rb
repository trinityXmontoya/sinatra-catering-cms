class CategoryImageUploader < CarrierWave::Uploader::Base
  storage :fog

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "category_images"
  end
end

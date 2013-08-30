class ImageUploader < FileUploader

  include CarrierWave::RMagick
  
  process :resize_to_fit => [200, 200]

  def extension_white_list
    %w(jpg jpeg gif png)
  end


  def store_dir
    "uploads/images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end

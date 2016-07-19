class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  version :thumb do
    process resize_to_fill: [200, 200]
  end

  version :medium do
    process resize_to_fill: [600, 800]
  end

  def content_type_whitelist
    /\Aimage\/.*\Z/
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
    end
end

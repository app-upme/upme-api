CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
    config.enable_processing = Rails.env.development?
  else
    config.storage    = :aws
    config.aws_bucket = Rails.application.secrets.aws_s3_bucket_name
    config.aws_acl    = 'public-read'

    config.aws_credentials = {
      access_key_id:     Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region:            Rails.application.secrets.aws_s3_region
    }
  end
end

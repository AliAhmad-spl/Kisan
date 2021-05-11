CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAWH4QJ2F3VWAHYVEC',                        # required unless using use_iam_profile
    aws_secret_access_key: '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',# required unless using use_iam_profile
    region: 'ap-south-1'
  }
  config.fog_directory  = 'easy-kisan'                                      # required
  config.fog_public     = false                                                 # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  # For an application which utilizes multiple servers but does not need caches persisted across requests,
  # uncomment the line :file instead of the default :storage.  Otherwise, it will use AWS as the temp cache store.
  # config.cache_storage = :file
end
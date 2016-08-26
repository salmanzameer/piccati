Raygun.setup do |config|
  config.api_key = "5Z53y3ZAeM0jQLykwv5L+g=="
  config.filter_parameters = Rails.application.config.filter_parameters

  # The default is Rails.env.production?
  # config.enable_reporting = !Rails.env.development? && !Rails.env.test?
end

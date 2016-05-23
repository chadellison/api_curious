Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, "CONSUMER_API_KEY", "CONSUMER_API_SECRET"
end

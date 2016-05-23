Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["CONSUMER_API_KEY"], ENV["CONSUMER_API_SECRET"]
end

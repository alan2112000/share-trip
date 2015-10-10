Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['facebook']['key'], ENV['facebook']['token']
end

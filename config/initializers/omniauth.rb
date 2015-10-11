Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV_SETTING['facebook']['key'], ENV['facebook']['token']
end

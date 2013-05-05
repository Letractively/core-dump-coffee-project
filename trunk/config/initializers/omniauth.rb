Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google, "364423984236.apps.googleusercontent.com", "tJxY3FYs3YKHUjhmEQPGCAZ5"
  provider :facebook, '454457254642243', '46a7765158243ecbe9254cc14819c209', :display => 'popup'
end
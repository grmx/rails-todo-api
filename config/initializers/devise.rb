Devise.setup do |config|
  config.password_length = 8..128
  config.navigational_formats = [:json]
end

Devise.setup do |config|

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  require 'omniauth-google-oauth2'
  config.omniauth :google_oauth2, '340740043588-rp8i5qbgvsudq9r1dvcv7iriih1n36im.apps.googleusercontent.com', 'RHbX3xfc1pIz6kR-AYQf0Vdf', {access_type: "offline", approval_prompt: ""}

  require 'omniauth-facebook'
  config.omniauth :facebook, '1701771886731756', 'd6cb6ad5106c976834d2cddd8acdc875'

  require 'omniauth-github'
  config.omniauth :github, '417180855f57b2c9de21', 'f7717217bb7c77cd4622dcfe60a46f7f4df6ade2', scope: "user:email"
  
end

if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    domain: 'http://127.0.0.1:3000',
    address:        "smtp.sendgrid.net",
    port:            587,
    authentication: :plain,
    user_name:      'apikey',
    password:       Rails.application.credentials['SENDGRID_API_KEY']
  }
end

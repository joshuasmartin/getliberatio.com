# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Global configuration.
Liberatio::Application.configure do

  # Use this Email configuration in all environments.
  config.action_mailer.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }

end

# Initialize the Rails application.
Liberatio::Application.initialize!

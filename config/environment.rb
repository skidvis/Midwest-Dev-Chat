# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :user_name => Rails.application.secrets.sendgrid_user,
    :password => Rails.application.secrets.sendgrid_password,
    :domain => 'midwestdevchat.com',
    :address => 'smtp.mailgun.org',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Scheduler::Application.initialize!


ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['sgcnrsrv@kke.com'],
  :password       => ENV['koji0537'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}

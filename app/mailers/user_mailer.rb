class UserMailer < ActionMailer::Base
  default from: "Joshua <joshua@getliberatio.com>"

  # Use views/layouts/user_mailer.(html.haml|.text.erb)
  layout 'user_mailer'

  def welcome_email(user)
    @user = user
    mail(to: @user.email_address, subject: "Welcome to Liberatio")
  end
end

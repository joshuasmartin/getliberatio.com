class UserMailer < ActionMailer::Base
  default from: "noreply@getliberatio.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email_address, subject: "Welcome to Liberatio")
  end
end

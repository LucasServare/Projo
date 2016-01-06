class WelcomeMailer < ApplicationMailer
  default from: 'notifications@projo.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Projo!')
  end

end

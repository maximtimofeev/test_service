class UserMailer < ApplicationMailer
  default from: 'website@events.com'

  def send_new_user_message(user)
    @user = user
    mail(to: user.email, subject: 'You account was successfully created!')
  end
end

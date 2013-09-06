class UserMailer < ActionMailer::Base
  default from: "#{ENV['GMAIL_USER']}@gmail.com"

  # app/mailers/user_mailer.rb
  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(:to => user.email,
         :subject => "Your password has been reset")
  end
end

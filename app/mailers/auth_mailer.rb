# Sends emails related to authentication
class AuthMailer < ApplicationMailer
  def sign_in_mail(user, auth_token)
    @user_name = user.name
    @sign_in_url = "#{ENV['FRONT_END_HOST']}/sign_in/?token="\
                   "#{auth_token}"

    mail(to: user.email, subject: t('sign_in_mail.subject'))
  end
end

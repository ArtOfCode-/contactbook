class UserMailer < ApplicationMailer
  def confirm(user, url_base)
    @user = user
    @url = "http://#{url_base}/users/confirm?token=#{user.confirmation_token}"
    mail to: "to@example.org"
  end
end

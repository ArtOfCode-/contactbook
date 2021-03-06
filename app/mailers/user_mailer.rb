class UserMailer < ApplicationMailer
  def confirm(user, url_base)
    @user = user
    @url = "http://#{url_base}/users/confirm?token=#{user.confirmation_token}"
    mail to: @user.email, from: "no-reply@#{url_base}"
  end
end

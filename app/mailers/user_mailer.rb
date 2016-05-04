class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #
  def registration_confirmation(resource)
    @greeting = "Hi"

    mail to: "code4startup@librex.co.jp"
  end
end

class UserMailer < ApplicationMailer
  default :from => 'code4startup@librex.co.jp'

  def registration_confirmation(resource)
    @greeting = "Hi"

    mail( to: resource.email, bcc: 'code4startup@librex.co.jp', subject: "#{resource.name}様、ご登録頂きありがとうございます。" )
  end
  
end
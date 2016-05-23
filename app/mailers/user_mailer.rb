class UserMailer < Devise::Mailer
  default from: Settings.admin['email']

  def registration_confirmation(resource)
    @resource = resource
    mail( to: resource.email, bcc: Settings.admin['email'], subject: "#{resource.name}様、ご登録頂きありがとうございます。" )
  end
  
end
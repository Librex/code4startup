class SignUpMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    super(record, token, opts.merge(:cc => "code4startup@librex.co.jp"))
  end
end
class ApplyJobMailer < ApplicationMailer
    def send_email(email_template, email)
    @email_template = email_template
    @mess = @email_template.body
    mail(to: email,subject: @email_template.subject)
  end
end

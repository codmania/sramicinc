class NewsletterMailer < ApplicationMailer
  def send_email(sub,mess,email)
    @mess = mess
    mail(to: email,subject: sub)
  end
end

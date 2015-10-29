class EmployerMailer < ApplicationMailer
	def send_email(sub,mess,email)
    @mess = mess
    mail(to: email,subject: sub)

  end
end

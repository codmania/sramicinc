class AlertMailer < ApplicationMailer
  def send_job_alert_email(email, res)
    @res = res
    mail(to: email,subject: 'Job Alert')
  end


  def send_talent_alert_email(email, res)
    @res = res
    mail(to: email,subject: 'Talent Alert')
  end
end

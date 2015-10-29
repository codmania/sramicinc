class EnquiryMailer < ApplicationMailer
  def enquiry_email(sub,mess, enquiry)
    @mess = mess
    @enquiry = enquiry
    mail(to: enquiry.email,subject: sub)
  end
end

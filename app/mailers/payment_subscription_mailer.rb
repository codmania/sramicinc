class PaymentSubscriptionMailer < ApplicationMailer
    def success_email(email, plan)
      @plan = plan
      @mess = 'You have successfully subscribed for plan  :'+@plan.name
      mail(to: email, subject: 'Plan Subscription')
    end


    def failure_email(email_template, email)
      @plan = plan
      @mess = 'You subscription failed for plan  :'+@plan.name
      mail(to: email, subject: 'Plan Subscription')
    end
end

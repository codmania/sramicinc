require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

module Clockwork

  ## Run below command to setup cron job 
  ## bundle exec clockwork lib/clock.rb

 #   every(10.seconds, 'Job Alert') { AlertsHelper.job_alert}
 #  every(10.seconds, 'Talent Alert') { AlertsHelper.talent_alert}
 #  if PaymentModule.first.active?
 #   every(10.seconds, 'Subscription  Validator') { AlertsHelper.subscription_checker}
 # end

  every(1.day, 'Job Status Change Alert', :at => '00:00') {AlertsHelper.job_status_change_alert}
   every(1.day, 'Job Alert', :at => '00:00') {AlertsHelper.job_alert}
   every(1.day, 'Talent Alert', :at => '00:00') {AlertsHelper.talent_alert}

   if PaymentModule.first.active?
     every(1.day, 'Subscription Validator', :at => '00:00') { AlertsHelper.subscription_checker}
   end






end
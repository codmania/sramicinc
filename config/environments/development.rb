Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = true

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true

  # config.action_mailer.default_url_options = { host: 'demo.sigmainfo.in:3003', port: 3003 }
  #
  # config.action_mailer.delivery_method = :smtp
  #
  # config.action_mailer.perform_deliveries = true
  #
  # config.action_mailer.smtp_settings = {
  #   :address              => "smtp.mandrillapp.com",
  #   :port                 => 587,
  #   :domain               => "gmail.com",
  #   :user_name            => "newron.dev@gmail.com",
  #   :password             => "ypUzfciN1NwK6B7_caB9uw",
  #   :authentication       => 'plain',
  #   :enable_starttls_auto => true
  # }

  # Use letter_opener to open the emails
  config.action_mailer.delivery_method = :letter_opener

  # App default url for emails sent from devise
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }


  config.after_initialize do
   ActiveMerchant::Billing::Base.mode = :test

    paypal_options = {
        login: "my_merchant-1_api1.gmail.com",
        password: "GV6AWH7UKTQP6EQV",
        signature: "AFcWxV21C7fd0v3bYYYRCpSSRl31A.vQ8bepLeoHIuRQK7GE-1mSwMGj"
    }
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end

end

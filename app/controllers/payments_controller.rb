class PaymentsController < ApplicationController

  before_action :activate_payment_module
  skip_filter :authenticate_user!, only: [:pricing,:jobseekerpricing]

  def index

    @plans = Plan.where(plan_type:current_user.role.authority)
    @plan = current_user.role.authority
  end


  def pricing
    @employerplans = Plan.where(plan_type:'employer')
    

  end

  def jobseekerpricing
    @jobseekerplans = Plan.where(plan_type:'jobseeker')
  end

  def checkout

    subscription = Subscription.find_by(user_id: current_user.id)

    @selected_plan = Plan.where(plan_type: current_user.role.authority, name: params[:plan]).first

    if !@selected_plan.nil? && subscription.end_date.nil?

       begin
            payment_initialize = EXPRESS_GATEWAY.setup_purchase(@selected_plan.price*100,
                                                                ip: request.remote_ip,
                                                                #return_url: "http://localhost:3000/payments/return_url?subscribed_plan=#{@selected_plan.id}",
                                                                #cancel_return_url: 'http://localhost:3000/payments/cancel_url',
                                                                return_url: url_for(action: 'return_url', :subscribed_plan => @selected_plan.id ),
                                                                cancel_return_url: url_for(action: 'cancel_url'),
                                                                currency: "USD",
                                                                allow_guest_checkout: false,
                                                                items: [{name: @selected_plan.name, description: @selected_plan.description, amount: @selected_plan.price*100}]
            )


            if payment_initialize.token.present?
              redirect_to EXPRESS_GATEWAY.redirect_url_for(payment_initialize.token)
              return
            else
              message = 'Something wrong, Please try again'
            end
       rescue => ex
             puts 'payment execption got :'+ex.to_s
             message = 'Something wrong, Please try again'
       end

    else
      message = 'You are already subscribed user'
    end
    redirect_to payments_path, alert: message

  end

  def return_url

    puts params

    @plan = Plan.find(params[:subscribed_plan])

    if params[:token].present? && params[:PayerID].present? && !@plan.nil?

      express_purchase_options =
          {
              ip: request.remote_ip,
              token: params[:token],
              payer_id: params[:PayerID],
          }

      payment_response = EXPRESS_GATEWAY.purchase(@plan.price*100, express_purchase_options)

      # puts payment_response.inspect
      #
      # puts '$$$$$$$$$$$'
      # puts payment_response.params
      # puts '$$$$$$$$$$$'
      # puts payment_response.params['PaymentInfo']
      # puts payment_response.params['PaymentInfo']['TransactionID']
      # puts '##############'

      if payment_response.success?


        subscription = Subscription.find_by(user_id: current_user.id)
        if subscription.nil?
          subscription = Subscription.create(user_id: current_user.id, plan_id: @plan.id, start_date: Time.now, end_date: Time.now+(@plan.days).days)
          PaymentInfo.create(transaction_id:payment_response.params['PaymentInfo']['TransactionID'],
                             parent_transaction_id:payment_response.params['PaymentInfo']['TransactionID'],
                             receipt_id:payment_response.params['PaymentInfo']['ReceiptID'],
                             transaction_type:payment_response.params['PaymentInfo']['TransactionType'],
                             payment_type:payment_response.params['PaymentInfo']['PaymentType'],
                             payment_date:payment_response.params['PaymentInfo']['PaymentDate'].to_date,
                             gross_amount:payment_response.params['PaymentInfo']['GrossAmount'].to_f,
                             fee_amount:payment_response.params['PaymentInfo']['FeeAmount'].to_f,
                             tax_amount:payment_response.params['PaymentInfo']['TaxAmount'].to_f,
                             exchange_rate:payment_response.params['PaymentInfo']['ExchangeRate'],
                             payment_status:payment_response.params['PaymentInfo']['PaymentStatus'],
                             pending_reason:payment_response.params['PaymentInfo']['PendingReason'],
                             reason_code:payment_response.params['PaymentInfo']['ReasonCode'],
                             subscription_id: subscription.id)

        else
          subscription.update_attributes(plan_id: @plan.id, start_date: Time.now, end_date: Time.now+(@plan.days).days)
          subscription.payment_info.update_attributes(transaction_id:payment_response.params['PaymentInfo']['TransactionID'],
                             parent_transaction_id:payment_response.params['PaymentInfo']['TransactionID'],
                             receipt_id:payment_response.params['PaymentInfo']['ReceiptID'],
                             transaction_type:payment_response.params['PaymentInfo']['TransactionType'],
                             payment_type:payment_response.params['PaymentInfo']['PaymentType'],
                             payment_date:payment_response.params['PaymentInfo']['PaymentDate'].to_date,
                             gross_amount:payment_response.params['PaymentInfo']['GrossAmount'].to_f,
                             fee_amount:payment_response.params['PaymentInfo']['FeeAmount'].to_f,
                             tax_amount:payment_response.params['PaymentInfo']['TaxAmount'].to_f,
                             exchange_rate:payment_response.params['PaymentInfo']['ExchangeRate'],
                             payment_status:payment_response.params['PaymentInfo']['PaymentStatus'],
                             pending_reason:payment_response.params['PaymentInfo']['PendingReason'],
                             reason_code:payment_response.params['PaymentInfo']['ReasonCode'],
                             subscription_id: subscription.id)
        end
        # TO DO- Success
        PaymentSubscriptionMailer.success_email(current_user.email, @plan).deliver_later
        redirect_to payments_path, notice: "you sucessfully  subscribed #{@plan.name} plan"
        return
      else
        # TO DO - Failure
        PaymentSubscriptionMailer.failure_email(current_user.email, @plan).deliver_later
        redirect_to payments_path, alert: "Something wrong, Please try again or contact to admin"
        return
      end
    else

    end

    redirect_to payments_path, alert: "Something wrong, Please try again or contact to admin"

  end

  def cancel_url
    puts "cancel_url called ***********"
    puts params
    redirect_to payments_path, error: 'Something wrong, Please try again'
  end


  def transfer_amount
    response = EXPRESS_GATEWAY.transfer(7000, 'my_buyer_account@gmail.com', :subject => "The money I owe you", :note => "Sorry it's so late")
    puts "transfered **********"
    render :text => response.inspect
    return
  end


end
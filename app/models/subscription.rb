class Subscription < ActiveRecord::Base

  belongs_to :plan
  belongs_to :user

  has_one :payment_info

  # has_one :transaction
end

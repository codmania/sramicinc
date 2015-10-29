class AddIndexToPaymentInfo < ActiveRecord::Migration
  def change
    add_index :payment_infos, :subscription_id
  end
end

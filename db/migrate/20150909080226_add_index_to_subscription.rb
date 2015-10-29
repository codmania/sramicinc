class AddIndexToSubscription < ActiveRecord::Migration
  def change
    add_index :subscriptions, :user_id
    add_index :subscriptions, :plan_id
  end
end

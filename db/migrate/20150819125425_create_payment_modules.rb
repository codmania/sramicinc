class CreatePaymentModules < ActiveRecord::Migration
  def change
    create_table :payment_modules do |t|
      t.boolean :active, :default => false

      t.timestamps null: false
    end
  end
end

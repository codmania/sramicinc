class CreatePaymentInfos < ActiveRecord::Migration
  def change
    create_table :payment_infos do |t|

      t.timestamps null: false

      t.string :transaction_id
      t.string :parent_transaction_id
      t.string :receipt_id

      t.string :transaction_type
      t.string :payment_type
      t.date :payment_date
      t.float :gross_amount
      t.float :fee_amount
      t.float :tax_amount
      t.string :exchange_rate
      t.string :payment_status
      t.string :pending_reason
      t.string :reason_code

      t.integer :subscription_id



      # TransactionID
      # ParentTransactionID
      # ReceiptID
      #
      # TransactionType
      # PaymentType
      # PaymentDate
      # GrossAmount
      # FeeAmount
      # TaxAmount
      # ExchangeRate
      # PaymentStatus
      # PendingReason
      # ReasonCode
      

    end
  end
end

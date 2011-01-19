class DropPaymentTransactions < ActiveRecord::Migration
  def self.up
    drop_table :payment_transactions
    remove_column :jobs , :payment_transaction_id
  end

  def self.down
    add_column :jobs ,:payment_transaction_id ,:integer
    create_table :payment_transactions do |t|
      t.string :payment_type
      t.string :transaction_id
      t.string :express_token
      t.string :express_payer_id
      t.string :ipaddress
      t.date :card_expires_on
      t.timestamps
    end
  end
end

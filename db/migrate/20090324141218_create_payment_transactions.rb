class CreatePaymentTransactions < ActiveRecord::Migration
  def self.up
    create_table :payment_transactions do |t|
      t.string :payment_type
      t.string :transaction_id
      t.timestamps
    end
    add_column :jobs ,:payment_transaction_id ,:integer
  end

  def self.down
    drop_table :payment_transactions
    remove_column :jobs , :payment_transaction_id
  end
end

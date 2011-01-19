class AddExpressTokenToPaymentTransaction < ActiveRecord::Migration
  def self.up
    add_column :payment_transactions, :express_token, :string
    add_column :payment_transactions, :express_payer_id, :string
    add_column :payment_transactions, :ipaddress, :string
    add_column :payment_transactions, :card_expires_on , :date
  end

  def self.down
    remove_column :payment_transactions, :express_payer_id
    remove_column :payment_transactions, :express_token
    remove_column :payment_transactions, :ipaddress
    remove_column :payment_transactions, :card_expires_on
  end
end

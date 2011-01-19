class UpdateUserNameEmailIndicesToNonUnique < ActiveRecord::Migration
  def self.up
    remove_index :users, :column => :email
    remove_index :users, :column => :name
    add_index :users, :name #, :unique => true
    add_index :users, :email #, :unique => true
  end

  def self.down
    remove_index :users, :column => :email
    remove_index :users, :column => :name
    add_index :users, :name, :unique => true
    add_index :users, :email, :unique => true
  end
end

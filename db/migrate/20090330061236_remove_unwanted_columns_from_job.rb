class RemoveUnwantedColumnsFromJob < ActiveRecord::Migration
  def self.up
    remove_column :jobs, :url
    remove_column :jobs, :email
    remove_column :jobs, :phone
  end

  def self.down
    add_column :jobs, :phone, :string
    add_column :jobs, :email, :string
    add_column :jobs, :url, :string
  end
end

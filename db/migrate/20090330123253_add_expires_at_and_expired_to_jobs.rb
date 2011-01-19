class AddExpiresAtAndExpiredToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :expires_at, :datetime
  end

  def self.down
    remove_column :jobs, :expires_at
  end
end

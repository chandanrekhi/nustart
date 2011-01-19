class AddColumnRenewdAtToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :renewed_at, :datetime
  end

  def self.down
    remove_column :jobs, :renewed_at
  end
end

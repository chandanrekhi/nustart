class RenameNoRenewalToAutoRenewal < ActiveRecord::Migration
  def self.up
    remove_column :jobs, :no_renewal
    add_column :jobs, :auto_renewal, :boolean, :default => true
    Job.all.each { |job| job.auto_renewal = true; job.save! }
  end

  def self.down
    remove_column :jobs, :auto_renewal
    add_column :jobs, :no_renewal, :boolean, :default => false
    Job.all.each { |job| job.no_renewal = false; job.save! }
  end
end

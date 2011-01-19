class CreateNoRenewalColumnForJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :no_renewal, :boolean, :default => false
    Job.all.each { |job| job.no_renewal = false; job.save! }
  end

  def self.down
    remove_column :jobs, :no_renewal
  end
end

class CreateJobRenewals < ActiveRecord::Migration
  def self.up
    create_table :job_renewals do |t|
      t.datetime  :renewed_at
      t.integer :job_id
    end
  end

  def self.down
    drop_table :job_renewals
  end
end

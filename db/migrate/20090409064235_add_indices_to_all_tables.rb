class AddIndicesToAllTables < ActiveRecord::Migration
  def self.up
    add_index :jobs, [:title, :startup_id], :unique => true
    add_index :jobs, :location
    add_index :jobs, :state
    add_index :industries, :name
    add_index :job_applications, :job_id
    add_index :job_renewals, :job_id
    add_index :startup_profiles, :startup_id, :unique => true
    add_index :startup_profiles, :industry_id
    add_index :users, :name, :unique => true
    add_index :users, :email, :unique => true
    add_index :users, :type
  end

  def self.down
    remove_index :users, :type
    remove_index :users, :column => :email
    remove_index :users, :column => :name
    remove_index :startup_profiles, :industry_id
    remove_index :startup_profiles, :column => :startup_id
    remove_index :job_renewals, :job_id
    remove_index :job_applications, :job_id
    remove_index :industries, :name
    remove_index :jobs, :state
    remove_index :jobs, :location
    remove_index :jobs, :column => [:title, :startup_id]
  end
end

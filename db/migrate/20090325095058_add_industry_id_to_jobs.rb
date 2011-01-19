class AddIndustryIdToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :industry_id, :integer
    add_index :jobs, :industry_id
  end

  def self.down
    remove_index :jobs, :industry_id
    remove_column :jobs, :industry_id
  end
end

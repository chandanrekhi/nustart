class UpdateColumnsInJobs < ActiveRecord::Migration
  def self.up
    remove_column :jobs, :description
    add_column :jobs, :overview, :text
    add_column :jobs, :responsibilities, :string
    add_column :jobs, :experience, :text
    add_column :jobs, :education, :text
    add_column :jobs, :compensation, :text
    add_column :jobs, :skills, :text
  end

  def self.down
    remove_column :jobs, :skills
    remove_column :jobs, :compensation
    remove_column :jobs, :education
    remove_column :jobs, :experience
    remove_column :jobs, :responsibilities
    remove_column :jobs, :overview
    add_column :jobs, :description, :text
  end
end

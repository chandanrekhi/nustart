class RenameProfileIdToCandidateIdInJobApplications < ActiveRecord::Migration
  def self.up
    rename_column :job_applications, :profile_id, :candidate_id
    remove_column :candidate_profiles, :candidate_id
    remove_column :candidate_profiles, :title
    remove_column :candidate_profiles, :description
    rename_table :candidate_profiles, :candidates
    add_column :candidates, :name, :string
    add_column :candidates, :email, :string
  end

  def self.down
    remove_column :candidates, :email
    remove_column :candidates, :name
    rename_table :candidates, :candidate_profiles
    add_column :candidate_profiles, :description, :text
    add_column :candidate_profiles, :title, :string
    add_column :candidate_profiles, :candidate_id, :integer
    rename_column :job_applications, :candidate_id, :profile_id
  end
end

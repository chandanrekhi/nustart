class RenameTableProfilesToCandidateProfiles < ActiveRecord::Migration
  def self.up
    rename_table :profiles, :candidate_profiles
  end

  def self.down
    rename_table :candidate_profiles, :profiles
  end
end

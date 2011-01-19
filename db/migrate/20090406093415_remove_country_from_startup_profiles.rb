class RemoveCountryFromStartupProfiles < ActiveRecord::Migration
  def self.up
    remove_column :startup_profiles, :country
  end

  def self.down
    add_column :startup_profiles, :country, :string
  end
end

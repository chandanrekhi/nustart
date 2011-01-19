class AddCountryToStartupProfiles < ActiveRecord::Migration
  def self.up
    add_column :startup_profiles, :country, :string
  end

  def self.down
    remove_column :startup_profiles, :country
  end
end

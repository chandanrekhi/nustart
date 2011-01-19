class AddLogoToStartupProfile < ActiveRecord::Migration
  def self.up
    add_column :startup_profiles, :logo_file_name,    :string
    add_column :startup_profiles, :logo_content_type, :string
    add_column :startup_profiles, :logo_file_size,    :integer
    add_column :startup_profiles, :logo_updated_at,   :datetime
  end

  def self.down
    remove_column :startup_profiles, :logo_file_name
    remove_column :startup_profiles, :logo_content_type
    remove_column :startup_profiles, :logo_file_size
    remove_column :startup_profiles, :logo_updated_at
  end

end

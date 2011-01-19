class ModifyJobAndStartupColumns < ActiveRecord::Migration
  def self.up
    change_column :jobs, :responsibilities, :text
    add_column :startup_profiles, :about, :text
  end

  def self.down
    remove_column :startup_profiles, :about
    change_column :jobs, :responsibilities, :string
  end
end

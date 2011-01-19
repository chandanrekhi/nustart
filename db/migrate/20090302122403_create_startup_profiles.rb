class CreateStartupProfiles < ActiveRecord::Migration
  def self.up
    create_table :startup_profiles do |t|
      t.column :address1, :string, :limit => 40
      t.column :address2, :string, :limit => 40
      t.column :city, :string, :limit => 40
      t.column :state, :string, :limit => 40
      t.column :pincode, :integer
      t.column :url, :string, :limit => 40
      t.column :funding, :boolean
      t.column :employees, :integer
      t.column :startup_id, :integer
      t.column :industry_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :startup_profiles
  end
end

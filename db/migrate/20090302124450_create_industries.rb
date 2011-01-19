class CreateIndustries < ActiveRecord::Migration
  def self.up
    create_table :industries do |t|
      t.column :name, :string, :limit => 40
      t.column :description, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :industries
  end
end

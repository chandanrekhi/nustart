class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :candidate_id
      t.string :title
      t.text :description
      t.string :resume

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end

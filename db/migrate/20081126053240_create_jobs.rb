class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :title
      t.integer :startup_id
      t.text :description
      t.string :email
      t.string :phone
      t.string :location
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end

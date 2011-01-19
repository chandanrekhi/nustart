class CreateJobApplications < ActiveRecord::Migration
  def self.up
    create_table :job_applications do |t|
      t.integer :job_id
      t.integer :profile_id
      t.string :subject
      t.text :cover_letter

      t.timestamps
    end
  end

  def self.down
    drop_table :job_applications
  end
end

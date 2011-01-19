class AddResumeToJobApplications < ActiveRecord::Migration
  def self.up
    add_column :job_applications, :resume_file_name, :string
    add_column :job_applications, :resume_content_type, :string
    add_column :job_applications, :resume_file_size, :integer
    add_column :job_applications, :resume_updated_at, :datetime
    add_column :job_applications, :email, :string
    add_column :job_applications, :name, :string
    remove_column :job_applications, :candidate_id
    drop_table :candidates
  end

  def self.down
    create_table "candidates", :force => true do |t|
      t.string   "resume"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "resume_file_name"
      t.string   "resume_content_type"
      t.integer  "resume_file_size"
      t.datetime "resume_updated_at"
      t.string   "name"
      t.string   "email"
    end
    add_column :job_applications, :candidate_id, :integer
    remove_column :job_applications, :name
    remove_column :job_applications, :email
    remove_column :job_applications, :resume_file_name
    remove_column :job_applications, :resume_content_type
    remove_column :job_applications, :resume_file_size
    remove_column :job_applications, :resume_updated_at
  end
end

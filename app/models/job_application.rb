# == Schema Information
# Schema version: 20090619053741
#
# Table name: job_applications
#
#  id                  :integer(4)      not null, primary key
#  job_id              :integer(4)
#  subject             :string(255)
#  cover_letter        :text
#  created_at          :datetime
#  updated_at          :datetime
#  resume_file_name    :string(255)
#  resume_content_type :string(255)
#  resume_file_size    :integer(4)
#  resume_updated_at   :datetime
#  email               :string(255)
#  name                :string(255)
#

class JobApplication < ActiveRecord::Base
  default_scope :order => 'created_at DESC'
  
  # Associations
  has_attached_file :resume,
                    :default_url => "",
                    # change url and path when deploying on production server
                    :url => "jobs/:job_id/job_applications/:id/resume",
                    :path => ":rails_root/job_applications/:startup_name/:job_title/:email.:extension"
  
  belongs_to :job
  belongs_to :candidate, :class_name => "Candidate", :foreign_key => "candidate_id"
  
  acts_as_textiled :cover_letter

  # Validations
  validates_presence_of :name, :job, :subject, :cover_letter, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  validates_attachment_presence :resume
  validates_attachment_size :resume, 
                            :less_than => 1.megabytes, 
                            :message => "must be less than 1 MB"
  validates_attachment_content_type :resume, 
                                    :content_type => [ 'application/pdf', 'application/doc', 'application/msword', 'application/force-download' ], 
                                    :message => "must be either a pdf or doc"
  
  attr_accessible :name, :email, :subject, :cover_letter, :resume
  
  def attachment
    resume.path.split('/').pop.split('?').shift
  end
  
end

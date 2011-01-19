# == Schema Information
# Schema version: 20090619053741
#
# Table name: job_renewals
#
#  id         :integer(4)      not null, primary key
#  renewed_at :datetime
#  job_id     :integer(4)
#

class JobRenewal < ActiveRecord::Base
  belongs_to :job
  validates_presence_of :renewed_at
end

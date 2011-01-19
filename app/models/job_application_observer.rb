class JobApplicationObserver < ActiveRecord::Observer
  def after_create(job_application)
    JobApplicationMailer.deliver_successfully_applied(job_application)
    JobApplicationMailer.deliver_received_new(job_application)
  end
end

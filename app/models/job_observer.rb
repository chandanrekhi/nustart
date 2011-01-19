class JobObserver < ActiveRecord::Observer
  def before_create(job)
    job.renewed_at = Time.now
    job.expires_at = Time.now + 1.month
  end
  
  def after_create(job)
    JobMailer.deliver_successfully_created(job)
  end
end

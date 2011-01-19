class JobApplicationMailer < ActionMailer::Base
  
  def successfully_applied(job_application)
    setup(job_application)
    subject       "[WFAS] You successfully applied for job - #{job_application.job.title}"
    recipients    "#{job_application.email}"
  end

  def received_new(job_application)
    setup(job_application)
    subject       "[WFAS] You have received new application for your job - #{job_application.job.title}"
    recipients    "#{job_application.job.startup.email}"
  end

  protected
  
  def setup(job_application)
    from         "administrator@workforastartup.com"
    sent_on      Time.now
    body         :body => {
                            :job_application => job_application,
                            :job => job_application.job,
                            :url => "http://#{HOST}/myaccount/startup/jobs/#{job_application.job.to_param}/applications/#{job_application.to_param}",
                            :job_url => "http://#{HOST}/jobs/#{job_application.job.to_param}" 
                          }
  end
  
end

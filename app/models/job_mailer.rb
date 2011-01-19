class JobMailer < ActionMailer::Base
  
  def successfully_created(job)
    setup(job)
    subject     "[WFAS] Your job posting was successfully created"
  end

  def successfully_renewed(job)
    setup(job)
    subject     "[WFAS] Your job posting was successfully renewed"
  end
  
  def expiring_in_2_days(job)
    setup(job)
    subject     "[WFAS] Your job posting will expire in 2 days."
  end

  def expired(job)
    setup(job)
    subject     "[WFAS] Your job posting has expired."
  end

  protected
  
  def setup(job)
    recipients  "#{job.startup.email}"
    from        "administrator@workforastartup.com"
    sent_on     Time.now
    body        :body => { 
                  :job => job,
                  :url => "http://#{HOST}/myaccount/startup/jobs/#{job.to_param}"
                }
  end
  
end

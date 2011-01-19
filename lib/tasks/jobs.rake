namespace :jobs do
  
  # desc "sends out an email to startups whose job opening is to be expired after 2 days"
  # task(:notify_expiring_in_2_days => :environment) do
  #   # Find jobs which are to be expired
  #   for job in Job.all_expiring_in_2_days
  #     puts "Emailing #{job.startup.name}"
  #     JobMailer.deliver_expiring_in_2_days(job)
  #     sleep 5
  #   end
  # end
  ## config/craken/raketab - 0 0 * * * jobs:notify_expiring_in_2_days > /tmp/jobs_notification.log 2>&1
  
  # desc "sends out an email to startups whose job opening has just expired, and changes its state to expired"
  # task(:notify_expired => :environment) do
  #   # Find jobs which are to be expired
  #   for job in Job.all_expired
  #     job.expired!
  #     puts "Emailing #{job.startup.name}"
  #     JobMailer.deliver_expired(job)
  #     sleep 5
  #   end
  # end
  ## config/craken/raketab - 0 */8 * * * jobs:notify_expired > /tmp/jobs_notification.log 2>&1
  
  desc "renews job opening which have just expired, and changes its state to renewed before sending email to startup"
  task(:notify_renewed => :environment) do
    # Find jobs which are to be expired
    for job in Job.all_expired
      job.renewed_at = Time.now
      job.expires_at = Time.now + 1.month
      if job.save!
        job.renewals << JobRenewal.create(:renewed_at => Time.now)
        job.renewed!
        ActionController::Base.new.expire_fragment(%r{base/jobs.*})
        ActionController::Base.new.expire_fragment(%r{base/search.*})
        ActionController::Base.new.expire_fragment(%r{jobs/*.cache})
        RAILS_DEFAULT_LOGGER.info("Job caches swept after renew")
        puts "Emailing #{job.startup.name}"
        JobMailer.deliver_successfully_renewed(job)
      end
      sleep 5
    end
  end
  
  desc "create expiry dates for jobs which don't have one"
  task(:generate_expiry_dates => :environment) do
    # job gets expired at one month it is created
    for job in Job.find(:all) 
      job.expires_at = job.created_at + 1.month
      job.save!
    end
  end
  
  desc "post jobs, with state created, to twitter every hour, and change their state to twittered"
  task(:post_to_twitter => :environment) do
    for job in Job.all_for_twitter
      tweet = Job.post('/statuses/update.json', :query => { :status => job.to_twitter })
      unless tweet["error"]
        job.twittered!
      end
      sleep 5
    end
  end
  
end
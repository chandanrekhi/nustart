class JobSweeper < ActionController::Caching::Sweeper
  
  observe Job
  
  def after_create(job)
    clear_jobs_cache_on_create(job)
  end
  
  def after_update(job)
    clear_jobs_cache_on_update(job)
  end
  
  def clear_jobs_cache_on_create(job)
    expire_fragment(%r{base/tags.*})
    expire_fragment(%r{jobs/industry/.*})
    expire_fragment(%r{jobs/tag/.*})
    expire_fragment(%r{base/jobs.*})
    expire_fragment(:controller => "/startups", :action => "show", :all_jobs => "all_jobs", :id => job.startup.id)
  end
  
  def clear_jobs_cache_on_update(job)
    expire_fragment(%r{base/tags.*})
    expire_fragment(%r{jobs/industry/.*})
    expire_fragment(%r{jobs/tag/.*})
    expire_fragment(%r{base/jobs.*})
    expire_fragment(:controller => "/jobs", :action => "show", :other_jobs => "other_jobs", :id => job.id)
    expire_fragment(:controller => "/jobs", :action => "show", :id => job.id)
  end
  
end
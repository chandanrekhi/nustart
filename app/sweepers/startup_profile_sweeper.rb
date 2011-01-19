class StartupProfileSweeper < ActionController::Caching::Sweeper
  
  observe StartupProfile
  
  def after_save(startup_profile)
    clear_startup_profiles_cache(startup_profile)
  end
  
  def clear_startup_profiles_cache(startup_profile)
    expire_fragment(%r{startups/list_by_letter/.*})
    expire_fragment(%r{startups.*})
    expire_fragment(:controller => "/startups", :action => "show", :id => startup_profile.startup.id)
    expire_fragment(%r{base/jobs.*})
    startup_profile.startup.jobs.each do |job|
      expire_fragment(:controller => "/jobs", :action => "show", :other_jobs => "other_jobs", :id => job.id)
      expire_fragment(:controller => "/jobs", :action => "show", :id => job.id)
    end
  end
  
end
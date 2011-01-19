class StartupProfileObserver < ActiveRecord::Observer
  def before_save(startup_profile)
    unless startup_profile.url.include?("http")
      startup_profile.url = "http://" + startup_profile.url
    end
  end
end
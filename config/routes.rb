ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "jobs"

  # Admin routes
  map.namespace :admin do |admin|
    admin.resources :users
    admin.resources :jobs
    admin.resources :job_applications
    admin.resources :industries
    admin.root :controller => 'dashboard'
  end

  # Myaccount routes
  map.namespace :myaccount do |mine|
    mine.namespace :startup do |star|
      star.resource :profile, :controller => "profile", :except => [ :new, :create ]
      star.resources :jobs, :collection => { :tag_suggestions => :get } do |job|
        job.auto_renew 'update_auto_renew', :controller => "jobs", :action => "update_auto_renew"
        job.resources :applications, :controller => "job_applications", :only => [ :index, :show ]
        job.get_resume "job_applications/:id/resume", :controller => 'job_applications', :action => 'get_resume'
      end
      star.all_job_applications 'all_job_applications', :controller => "job_applications", :action => "listing_all"
      star.resources :payment_transactions , :new => {:express => :get}
    end
    mine.root :controller => "startup/profile", :action => "show"
  end
  
  map.resources :users, :only => [ :new, :create ]  
  map.resources :jobs, :only => [ :index, :show ] do |job|
    job.resource :application, :controller => "job_applications", :only => [ :new, :create ]
  end
  map.jobs_by_tag '/jobs/tag/:tag.:format', :controller => "jobs", :action => "listing_by_tag"
  map.jobs_by_industry 'jobs/industry/:industry.:format', :controller => "jobs", :action => "listing_by_industry"
  map.resources :startups
  map.startups_by_letter "/startups/list_by_letter/:letter", :controller => "startups", :action => "list_by_letter"
  map.resource :session
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password/:code', :controller => 'users', :action => 'reset_password'
  # pages
  map.tour 'tour', :controller => "pages", :action => "tour"
  map.about 'about', :controller => "pages", :action => "about"
  map.contact 'contact', :controller => "pages", :action => "contact"
  map.terms 'terms', :controller => "pages", :action => "terms"
  map.policy 'policy', :controller => "pages", :action => "policy"
  map.faq 'faq', :controller => "pages", :action => "faq"
  
  map.connect ':controller/:action/:id'
end
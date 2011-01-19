class Myaccount::Startup::JobApplicationsController < ApplicationController
  
  before_filter :login_required, :only => [ :get_resume ]
  before_filter :startup_required, :except => [ :get_resume ]
  layout "myaccount"
  
  # GET /myaccount/startup/job_applications
  def index
    @myaccount_startup_job = Job.find(params[:job_id], :conditions => [ "startup_id = ?", current_user.id ])
    @myaccount_startup_job_applications =  @myaccount_startup_job.job_applications.paginate :page => params[:page], :per_page => PER_PAGE
    @count = @myaccount_startup_job.job_applications.size
    set_page_vars
  end

  # GET /myaccount/startup/job_applications/listing_all
  def listing_all
    @myaccount_startup_job_applications = JobApplication.paginate(:all, :joins => :job, :conditions => [ "jobs.startup_id = ?", current_user.id ], :page => params[:page], :per_page => PER_PAGE)
    @count = JobApplication.find(:all, :joins => :job, :conditions => [ "jobs.startup_id = ?", current_user.id ]).size
    set_page_vars
    render :action => "index"
  end
  
  # GET /myaccount/job_applications/1
  def show
    @myaccount_startup_job_application = JobApplication.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @myaccount_startup_job_application }
    end
  end
  
  def get_resume
    send_file(JobApplication.find(params[:id]).resume.path, :disposition => 'inline')
  end
  
end

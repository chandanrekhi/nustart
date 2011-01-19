class Myaccount::Startup::JobsController < ApplicationController
  
  before_filter :login_required, :only => [ :tag_suggestions ]
  before_filter :startup_required, :except => [ :tag_suggestions ]
  layout 'myaccount'
  
  cache_sweeper :job_sweeper, :only => [ :create, :update, :renew ]
  
  # GET myaccount/startup/jobs
  def index
    @jobs = current_user.jobs.paginate :page => params[:page], :per_page => PER_PAGE
    @count = current_user.jobs.size
    set_page_vars
  end
  
  def tag_suggestions
    @tags = Tag.find(:all, :conditions => ["name LIKE ?", "%#{params[:search]}%"])
    render :layout => false
  end
  
  # GET myaccount/startup/jobs/1
  def show
    @job = Job.find(params[:id])
    @other_jobs = @job.startup.jobs - [@job]
  end

  # GET myaccount/startup/jobs/new
  def new
    @job = Job.new
  end
  
  # GET myaccount/startup/jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST myaccount/startup/jobs
  def create
    @job = Job.new(params[:job])
    @job.startup = current_user
    @job.industry = current_user.startup_profile.industry
    @job.save_cached_tag_list
    if @job.save
      flash[:notice] = 'Job was successfully created.'
      redirect_to(myaccount_startup_job_path(@job))
    else
      render :action => "new"
    end
  end

  # PUT myaccount/startup/jobs/1
  def update
    @job = Job.find(params[:id])
    @job.save_cached_tag_list
    if @job.update_attributes(params[:job])
      flash[:notice] = 'Job was successfully updated.'
      redirect_to(myaccount_startup_job_path(@job))
    else
      render :action => "edit"
    end
  end
  
  def update_auto_renew
    @job = Job.find(params[:job_id])
    @job.auto_renewal = params[:query] == "false" ? 1 : 0
    if @job.save!
      render :update do |page|
        page.replace_html "td_auto_renew_#{@job.id}", :partial => '/jobs/check_box_auto_renew', :locals => { :job => @job }
      end
    end
  end
  
end
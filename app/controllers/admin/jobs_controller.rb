class Admin::JobsController < ApplicationController
  
  before_filter :manager_required
  before_filter :set_vars, :except => [ :index, :show, :destroy ]
  layout 'admin'
  
  cache_sweeper :job_sweeper, :only => [ :create, :update, :destroy ]
  
  # GET /admin_jobs
  def index
    @admin_jobs = Job.paginate :page => params[:page], :per_page => PER_PAGE
    set_page_vars
  end

  # GET /admin_jobs/1
  def show
    @admin_job = Job.find(params[:id])
  end

  # GET /admin_jobs/new
  def new
    @admin_job = Job.new
  end

  # GET /admin_jobs/1/edit
  def edit
    @admin_job = @job = Job.find(params[:id])
  end

  # POST /admin_jobs
  def create
    @admin_job = Job.new(params[:job])
    startup = Startup.find(params[:job][:startup_id])
    @admin_job.startup = startup
    @admin_job.industry = startup.startup_profile.industry
    if @admin_job.save
      flash[:notice] = 'Job was successfully created.'
      redirect_to(admin_job_path(@admin_job))
    else
      render :action => "new"
    end
  end

  # PUT /admin_jobs/1
  def update
    @admin_job = @job = Job.find(params[:id])
    if @admin_job.update_attributes(params[:job])
      flash[:notice] = 'Job was successfully updated.'
      redirect_to(admin_job_path(@admin_job))
    else
      render :action => "edit"
    end
  end

  # DELETE /admin_jobs/1
  def destroy
    @admin_job = Job.find(params[:id])
    @admin_job.destroy
    redirect_to(admin_jobs_url)
  end
  
  private
  def set_vars
    @startups = User.find(:all, :select => "id, name", :conditions => ["type = ?", 'startup'])
  end
end

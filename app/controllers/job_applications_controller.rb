class JobApplicationsController < ApplicationController

  # GET /job_applications/new
  def new
    @job = Job.find(params[:job_id])
    @other_jobs = @job.startup.jobs
    @job_application = JobApplication.new
  end

  # POST /job_applications
  def create
    @job = Job.find(params[:job_id])
    @other_jobs = @job.startup.jobs
    @job_application = JobApplication.new(params[:job_application])
    @job_application.job = @job
    if @job_application.save
      flash[:notice] = 'Your application was sucessfully submitted.'
      redirect_to(job_path(@job))
    else
      render :action => "new"
    end
  end
  
end

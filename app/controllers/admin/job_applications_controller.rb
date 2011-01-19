class Admin::JobApplicationsController < ApplicationController
  
  before_filter :manager_required
  layout 'admin'
  
  # GET /admin_job_applications
  def index
    @admin_job_applications = JobApplication.all
  end

  # GET /admin_job_applications/1
  def show
    @admin_job_application = JobApplication.find(params[:id])
  end

  # DELETE /admin_job_applications/1
  def destroy
    @admin_job_application = JobApplication.find(params[:id])
    @admin_job_application.destroy
    redirect_to(admin_job_applications_url)
  end
end

class Myaccount::Startup::ProfileController < ApplicationController
  
  before_filter :startup_required
  # skip_before_filter :profile_required, :only => [ :new, :create ]
  layout 'myaccount'
  
  cache_sweeper :startup_profile_sweeper, :only => [ :update ]
  
  def show
    @startup_profile = current_user.startup_profile
  end

  # def new
  #   @startup_profile = StartupProfile.new
  # end

  def edit
    @startup_profile = current_user.startup_profile
  end

  # def create
  #   @startup_profile = StartupProfile.new(params[:startup_profile])
  #   @startup_profile.startup = current_user
  #   if @startup_profile.save!
  #     flash[:notice] = 'Profile was successfully created.'
  #     redirect_to(myaccount_startup_profile_path)
  #   else
  #     render :action => "new"
  #   end
  # end

  def update
    @startup_profile = current_user.startup_profile
    if @startup_profile.update_attributes(params[:startup_profile])
      for job in @startup_profile.startup.jobs
        unless job.industry_id == @startup_profile.industry_id
          job.industry_id = @startup_profile.industry_id
          job.save!
        end
      end
      flash[:notice] = 'StartupProfile was successfully updated.'
      redirect_to(myaccount_startup_profile_path)
    else
      render :action => "edit"
    end
  end
  
end

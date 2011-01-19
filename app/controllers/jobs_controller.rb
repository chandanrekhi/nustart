class JobsController < ApplicationController
  
  # GET /jobs
  # GET /jobs.atom
  
  def index
    # unless read_fragment({ :controller => "base", :action => "jobs", :page => params[:page] || 1})
      @all_jobs = Job.find(:all) #, :conditions => SqlCondition::Job.not_expired
      @count = @all_jobs.size
      @jobs = Job.paginate :page => params[:page], :per_page => PER_PAGE #, :conditions => SqlCondition::Job.not_expired
      set_page_vars
    # end
    respond_to do |format|
      format.html # index.html.haml
      format.atom # index.atom.builder
    end
  end

  # GET /jobs/tag/:tag.html
  # GET /jobs/tag/:tag.atom
  def listing_by_tag
    # unless read_fragment({:controller => "base", :action => "jobs", :page => params[:page] || 1, :query => params[:tag]})
      @all_jobs = Job.find_tagged_with(params[:tag])
      @jobs = Job.paged_find_tagged_with(params[:tag], :page => params[:page], :per_page => PER_PAGE)
      @count = @all_jobs.size
      @query = @tag = params[:tag]
      set_page_vars
    # end
    respond_to do |format|
      format.html { render :action => :index }
      format.atom { render :action => :index }
    end
  end
  
  # GET /jobs/industry/:industry_id.html
  # GET /jobs/industry/:industry_id.atom
  def listing_by_industry
    # unless read_fragment({:controller => "base", :action => "jobs", :page => params[:page] || 1, :query => params[:industry]})
      @industry = Industry.find(params[:industry])
      @all_jobs = Job.find(:all, :conditions => SqlCondition::Job.not_expired_by_industry(params[:industry]))
      @jobs = Job.paginate :page => params[:page], :per_page => PER_PAGE, :conditions => SqlCondition::Job.not_expired_by_industry(params[:industry])
      @count = @all_jobs.size
      @query = @industry.name
      set_page_vars
    # end
    respond_to do |format|
      format.html { render :action => :index }
      format.atom { render :action => :index }
    end
  end
  
  # GET /jobs/1
  def show
    # unless read_fragment({:id => params[:id]})
      @job = Job.find(params[:id])
      # unless @job.expires_at > Time.now
      #   redirect_to '/422.html' and return
      # end
    # end
  end
  
end
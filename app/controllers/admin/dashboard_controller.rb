class Admin::DashboardController < ApplicationController

  before_filter :manager_required
  layout 'admin'
  
  def index
    # All startups data for pie chart    
    @all_startups_for_pie_chart = Startup.all_startups_for_pie_chart
    # All job openings data for pie chart
    @all_jobs_created_for_pie_chart = {:data => [], :labels => []}
    @all_jobs_expired_for_pie_chart = {:data => [], :labels => []}
    @all_jobs_renewed_for_pie_chart = {:data => [], :labels => []}
  end
end

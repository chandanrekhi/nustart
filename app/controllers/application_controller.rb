# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  before_filter :basic_authenticate
  
  include AuthenticatedSystem
  
  before_filter :capture_406
  # before_filter :profile_required
  
  helper :all # include all helpers, all the time

  helper_method :read_fragment
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '14f626c4996faddb4aa76eb059b98daf'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  private
  # def profile_required
  #   if current_user and (current_user.kind_of?(Startup) and current_user.startup_profile.nil?)
  #     flash.now[:error] = "Please create your profile first"
  #     redirect_to new_myaccount_startup_profile_path
  #   end
  # end
  
  def set_page_vars
    @page = params[:page] ? params[:page].to_i : START_PAGE
    @per_page = PER_PAGE
  end
  
  def capture_406
    redirect_to "/406.html" unless params[:format].blank? or %w(html atom js).include?(params[:format])
  end
  
  def basic_authenticate
    unless RAILS_ENV == "production"
      authenticate_or_request_with_http_basic do |username, password|
        username == "wfas" and password == "iloveyou"
      end
    end
  end
end

ActionView::Base.send                     :include, AjaxValidation::Helpers
ActionView::Base::CompiledTemplates.send  :include, AjaxValidation::FormBuilders
ActionController::Base.send               :include, AjaxValidation::ControllerMethods
ActiveRecord::Base.send                   :include, AjaxValidation::ModelMethods
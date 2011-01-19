class UsersController < ApplicationController  

  cache_sweeper :user_sweeper, :only => [ :activate ]
  acts_as_ajax_validation
  
  # render new.rhtml
  def new
    @startup = Startup.new
    @startup.startup_profile = StartupProfile.new
  end
 
  def create
    logout_keeping_session!
    @startup = (params[:startup][:type] || "Startup").constantize.new(params[:startup]) #Users
    success = @startup && @startup.save
    if success && @startup.errors.empty?
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      redirect_to '/login'
    else
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  # action to perform when the users clicks forgot_password
  # -> CM - takes care of sending request to admin to enable account if it is disabled
  def forgot_password
    return unless request.post?
    unless params[:user][:email] and params[:user][:email].blank?
      if @user = User.find_by_email(params[:user][:email])
        @user.forgot_password
        @user.save
        flash[:notice] = "A password reset link has been sent to your email address: #{params[:user][:email]}"
        redirect_to login_path
      else
        flash[:error] = "Could not find a user with that email address: #{params[:user][:email]}"
      end
    else
      flash[:error] = "Email should not be blank"
    end
  end

  # action to perform when the user resets the password
  def reset_password
    @user = User.find_by_password_reset_code(params[:code])
    raise unless @user
      return if @user unless params[:user]
      if ((params[:user][:password] && params[:user][:password_confirmation]))
        unless params[:user][:password].blank?
          if params[:user][:password] == params[:user][:password_confirmation]
            @user.password_confirmation = params[:user][:password_confirmation]
            @user.password = params[:user][:password]
            @user.reset_password
            if @user.save
              flash[:notice] = "Password reset successfully"
              redirect_to login_path
            else
              render :action => :reset_password
            end
          else
            flash[:error] = "Password and Password Confirmation don't match"
          end
        else
          flash[:error] = "Password should not be blank"
        end
      end
    rescue
      logger.error "Invalid Reset Code entered"
      flash[:error] = "Password reset code has either expired or is invalid.
                       Please check your email and try again."
      redirect_to login_path
  end
  
end
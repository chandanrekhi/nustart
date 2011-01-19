class Admin::UsersController < ApplicationController

  before_filter :manager_required
  layout 'admin'

  # GET /admin_users
  def index
    @admin_users = User.paginate :page => params[:page], :per_page => PER_PAGE
  end

  # GET /admin_users/1
  def show
    @admin_user = User.find(params[:id])
  end

  # GET /admin_users/new
  def new
    @admin_user = User.new
  end

  # GET /admin_users/1/edit
  def edit
    @admin_user = User.find(params[:id])
  end

  # POST /admin_users
  def create
    @admin_user = User.new(params[:user])
    if @admin_user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to(admin_user_path(@admin_user))
    else
      render :action => "new"
    end
  end

  # PUT /admin_users/1
  def update
    @admin_user = User.find(params[:id])
    if @admin_user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to(admin_user_path(@admin_user))
    else
      render :action => "edit"
    end
  end

  # DELETE /admin_users/1
  def destroy
    @admin_user = User.find(params[:id])
    @admin_user.destroy
    redirect_to(admin_users_url)
  end
  
end

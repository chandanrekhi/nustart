class Admin::IndustriesController < ApplicationController
  
  before_filter :manager_required
  layout 'admin'
  
  # GET /admin_industries
  def index
    @admin_industries = Industry.all
  end

  # GET /admin_industries/1
  def show
    @admin_industry = Industry.find(params[:id])
  end

  # GET /admin_industries/new
  def new
    @admin_industry = Industry.new
  end

  # GET /admin_industries/1/edit
  def edit
    @admin_industry = Industry.find(params[:id])
  end

  # POST /admin_industries
  def create
    @admin_industry = Industry.new(params[:industry])
    if @admin_industry.save
      flash[:notice] = 'Industry was successfully created.'
      redirect_to(admin_industry_path(@admin_industry))
    else
      render :action => "new"
    end
  end

  # PUT /admin_industries/1
  def update
    @admin_industry = Industry.find(params[:id])
    if @admin_industry.update_attributes(params[:industry])
      flash[:notice] = 'Industry was successfully updated.'
      redirect_to(admin_industry_path(@admin_industry))
    else
      render :action => "edit"
    end
  end

  # DELETE /admin_industries/1
  def destroy
    @admin_industry = Industry.find(params[:id])
    @admin_industry.destroy
    redirect_to(admin_industries_url)
  end
  
end

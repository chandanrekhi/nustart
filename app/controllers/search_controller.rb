class SearchController < ApplicationController
  
  def index
    if params[:query] and !params[:query].blank?
      session[:query] = params[:query]
    else
      flash.now[:error] = "Please enter the keyword to search for"
      session[:query] = ""
    end
    @query = ""
    @squery = session[:query]
    if params[:location] and !params[:location].blank?
      @query += "location:#{params[:location]} "
      @squery += " at #{params[:location]}"
    end
    if params[:industry] and !params[:industry].blank?
      @query += "industry:#{params[:industry]} "
      @squery += " in #{Industry.find(params[:industry]).name}"
    end
    @query += session[:query]
    @page = params[:page] ? params[:page].to_i : START_PAGE
    @per_page = params[:per_page] ? params[:per_page].to_i : PER_PAGE
    @search = ActsAsXapian::Search.new(models, @query, :limit => @per_page, :offset => offset(@page, @per_page), :sort_by_prefix => "renewed_at")
    # @new_collection = @search.results.collect {|r| r[:model]}
    # # a quick hack to exclude all expired jobs out of search
    # # -> acts_as_xapian lacks scoped searches
    # @resultset = []; @new_collection.each { |nc| @resultset << nc if nc and (nc.created? or nc.twittered? or nc.renewed?) }
    @resultset = @search.results.collect {|r| r[:model]}
    @count = @resultset.size
    @correction = @search.spelling_correction
    respond_to do |format|
      format.html # index.html.haml
      format.atom # index.atom.builder
      format.xml  { render :xml => @resultset }
    end
  end
  
  private
  
  def models
    %w(Job)
  end
  
  def offset(page, per_page)
    (page-1)*per_page
  end

end

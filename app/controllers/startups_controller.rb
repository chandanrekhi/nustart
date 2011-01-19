class StartupsController < ApplicationController
  
  require 'rubygems'
  include Geokit::Geocoders
  
  # GET /startups
  # GET /startups.xml
  def index
    unless read_fragment({:page => params[:page] || 1})
      @startups = Startup.paginate :page => params[:page], :per_page => PER_PAGE, :include => :startup_profile, :conditions => [ "startup_profile.startup_id != ?", "NULL" ]
      @count = Startup.find(:all, :include => :startup_profile, :conditions => [ "startup_profile.startup_id != ?", "NULL" ]).size
      set_page_vars
    end
  end

  def list_by_letter
    unless read_fragment({:page => params[:page] || 1, :letter => params[:letter]})
      @startups = Startup.paginate :page => params[:page], :per_page => PER_PAGE, :include => :startup_profile, :conditions => ["UCASE(LEFT(name,1)) = ? and startup_profiles.startup_id != ?", params[:letter].upcase, "NULL"]
      @count = Startup.find(:all, :include => :startup_profile, :conditions => ["UCASE(LEFT(name,1)) = ? and startup_profiles.startup_id != ?", params[:letter].upcase, "NULL"]).size
      @letter = params[:letter]
      set_page_vars
    end
    render :action => :index
  end
  
  # GET /startups/1
  # GET /startups/1.xml
  def show
    unless read_fragment({ :id => params[:id] })
      @startup = Startup.find(params[:id])
      if @startup.startup_profile
        gmapskey = YAML.load_file(RAILS_ROOT + '/config/gmaps_api_key.yml')[ENV['RAILS_ENV']]
        res = MultiGeocoder.geocode(@startup.startup_profile.gmap_address)
        if res.success
      	  marker1 = StaticGmaps::Marker.new(
      	    :latitude => res.lat,
      	    :longitude => res.lng
      	  )
      	  @map = StaticGmaps::Map.new(
      	    :center => [ res.lat, res.lng ], 
      	    :markers => [ marker1 ],
      	    :zoom => 13, 
      	    :map_type => :mobile, 
      	    :size => [ 630, 300 ],
      	    :key => gmapskey
      	  )
        else
          logger.warn "Address '#{@startup.startup_profile.gmap_address}' could not be located for Google Maps"
        end 
      else
        redirect_to '/404.html' and return
      end
    else
      @startup = Startup.find(params[:id])
    end
  end

end

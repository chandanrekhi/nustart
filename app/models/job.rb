# == Schema Information
# Schema version: 20090619053741
#
# Table name: jobs
#
#  id               :integer(4)      not null, primary key
#  title            :string(255)
#  startup_id       :integer(4)
#  location         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  overview         :text
#  responsibilities :text
#  experience       :text
#  education        :text
#  compensation     :text
#  skills           :text
#  cached_tag_list  :string(255)
#  industry_id      :integer(4)
#  expires_at       :datetime
#  renewed_at       :datetime
#  state            :string(255)
#  auto_renewal     :boolean(1)      default(TRUE)
#

class Job < ActiveRecord::Base
  
  include AASM
  
  default_scope :order => 'renewed_at DESC, created_at DESC'
  
  # states
  aasm_column :state
  aasm_initial_state :created
  aasm_state :created
  aasm_state :twittered
  aasm_state :renewed
  aasm_event :twittered do
    transitions :to => :twittered, :from => [:created, :renewed]
  end
  aasm_event :renewed do
    transitions :to => :renewed, :from => [:created, :twittered]
  end
  
  # Post jobs on Twitter
  include HTTParty
  base_uri 'twitter.com'
  basic_auth 'username', 'password'
  
  # Associations
  belongs_to :startup
  belongs_to :industry
  has_many :job_applications
  has_many :renewals, :class_name => "JobRenewal"
  
  # Validations
  validates_uniqueness_of :title, :scope => "startup_id"
  validates_presence_of :title, :overview, :startup
  
  acts_as_taggable
  validates_presence_of :tag_list, :on => :save, :message => "can't be blank"
  
  acts_as_xapian :texts => [:startup_name, :startup_location, :title, :cached_tag_list, :overview, :location, :responsibilities, :education, :experience, :skills],
                 :values => [[:renewed_at, 0, "renewed_at", :date]], 
                 :terms => [[ :job_location, 'L', "location" ], [ :industry_id, 'T', "industry" ]] 
                 
  acts_as_textiled :overview, :responsibilities, :experience, :education, :compensation, :skills
  
  attr_accessible :title, :tag_list, :email, :phone, :location, :url, :overview, :responsibilities, :experience, :education, :compensation, :skills
  
  def startup_name
    self.startup.name
  end
  
  def startup_location
    self.startup.startup_profile.city
  end

  def job_location
    if self.location.blank?
      self.startup.startup_profile.city
    else
      self.location
    end
  end
  
  def industry
    self.startup.startup_profile.industry
  end
  
  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def to_twitter
    if self.renewals.empty?
      "#rtjobs #wfas #India http://#{HOST}/jobs/#{to_param} #{title} at #{startup_name} (#{job_location})"
    else
      "#rtjobs #wfas #India http://#{HOST}/jobs/#{to_param} #{title} - renew-#{self.renewals.size} at #{startup_name} (#{job_location})"
    end
  end
  
  class << self
    # def all_expiring_in_2_days
    #   find(:all, :conditions => [ "expires_at < ? and expires_at > ?", Time.now + 2.days, Time.now ], :order => "renewed_at ASC, created_at ASC")
    # end
    
    def all_expired
      find(:all, :conditions => [ "expires_at < ? and state = ? and auto_renewal = ?", Time.now, "twittered", true ], :order => "renewed_at ASC, created_at ASC")
    end
    
    def all_for_twitter
      find(:all, :conditions => [ "(state = ? or state = ?) and expires_at > ?", "created", "renewed", Time.now ], :order => "renewed_at ASC, created_at ASC")
    end
    
    def find_with_xapian(search_term, options={})
      ActsAsXapian::Search.new([self], search_term, options).results.collect{|x| x[:model]}
    end
  end
  
end

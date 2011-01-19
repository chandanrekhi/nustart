# == Schema Information
# Schema version: 20090619053741
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  name                      :string(100)     default("")
#  email                     :string(100)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  activation_code           :string(40)
#  activated_at              :datetime
#  type                      :string(255)
#  password_reset_code       :string(40)
#

require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  default_scope :order => 'name ASC'
  
  validates_presence_of     :name, :email
  validates_uniqueness_of   :name, :email
  validates_format_of       :name, :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name, :maximum => 100
  validates_length_of       :email, :within => 6..100
  validates_format_of       :email, :with => Authentication.email_regex, :message => Authentication.bad_email_message
  # validates_inclusion_of    :type, :in => %w(Manager Startup) #  Agency Candidate

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :name, :password, :password_confirmation, :type
  
  before_create             :make_activation_code 

  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end
  
  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end

  def reset_password
    # First update the password_reset_code before setting the
    # reset_password flag to avoid duplicate mail notifications.
    self.password_reset_code = nil
    self.save
    @reset_password = nil
  end
  
  # Used in user_observer
  def recently_forgot_password?
    @forgotten_password
  end

  # Used in user_observer
  def recently_reset_password?
    @reset_password
  end
  
  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['email = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def manager?
    self.is_a? Manager
  end
  
  def startup?
    self.is_a? Startup
  end
  
  def generate_activation_code
    make_activation_code
  end
  
  protected
    def make_password_reset_code
      self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
  
    def make_activation_code
      self.activation_code = self.class.make_token
    end

end

class Manager < User; end

class Startup < User
  # Associations
  has_many :jobs, :dependent => :destroy
  has_one :startup_profile, :dependent => :destroy
  
  accepts_nested_attributes_for :startup_profile
  
  attr_accessible :startup_profile_attributes
  
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def all_job_applications
    job_applications = []
    self.jobs.each { |job| job.job_applications.find(:all, :order => "created_at DESC").each { |ja| job_applications << ja } }
    job_applications
  end
  
  # returns an array of numbers - startups created in 12-6-3-1 months
  def self.all_startups_for_pie_chart
    tot_startups_in_12_months = find(:all, :conditions=>["created_at >= ?", 12.months.ago.to_s[0,19]]).size
    tot_startups_in_6_months = find(:all, :conditions=>["created_at >= ?", 6.months.ago.to_s[0,19]]).size
    tot_startups_in_3_months = find(:all, :conditions=>["created_at >= ?", 3.months.ago.to_s[0,19]]).size
    tot_startups_in_1_month = find(:all, :conditions=>["created_at >= ?", 1.month.ago.to_s[0,19]]).size
    return {:data => [tot_startups_in_12_months,tot_startups_in_6_months,tot_startups_in_3_months,tot_startups_in_1_month],
            :labels => ["12(#{tot_startups_in_12_months})", "6(#{tot_startups_in_6_months})", "3(#{tot_startups_in_3_months})", "1(#{tot_startups_in_1_month})"]}
  end
end

# == Schema Information
# Schema version: 20090619053741
#
# Table name: startup_profiles
#
#  id                :integer(4)      not null, primary key
#  address1          :string(40)
#  address2          :string(40)
#  city              :string(40)
#  state             :string(40)
#  pincode           :integer(4)
#  url               :string(40)
#  funding           :boolean(1)
#  employees         :integer(4)
#  startup_id        :integer(4)
#  industry_id       :integer(4)
#  created_at        :datetime
#  updated_at        :datetime
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer(4)
#  logo_updated_at   :datetime
#  about             :text
#

class StartupProfile < ActiveRecord::Base
  has_attached_file :logo, 
                    :styles => { :big => "285x190>", :small => "135x85>", :thumb => "45x20>" },
                    :default_url => "missing_logo.gif"
  # validates_attachment_presence :logo
  validates_attachment_content_type :logo, :content_type => [ 'image/png', 'image/jpeg', 'image/gif', 'image/pjpeg' ]
  validates_attachment_size :logo, :less_than => 1.megabytes
  
  belongs_to :startup
  belongs_to :industry
  
  validates_presence_of :address1, :city, :state, :url, :employees, :industry 
                 
  acts_as_textiled :about
    
  attr_accessible :about, :url, :employees, :funding, :logo, :address1, :address2, :city, :state, :pincode, :industry_id
  
  def full_address
    add = address
    add += ", India"
    add += "."
  end
  
  def gmap_address
    add = address
    add += ", India"
  end
  
  private
  def address 
    address = ""
    address += address1 + ", " unless address1.blank? 
    address += address2 + ", " unless address2.blank?
    address += city + ", " unless city.blank?
    address += state unless state.blank?
  end
end

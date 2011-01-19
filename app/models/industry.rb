# == Schema Information
# Schema version: 20090619053741
#
# Table name: industries
#
#  id          :integer(4)      not null, primary key
#  name        :string(40)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Industry < ActiveRecord::Base
  default_scope :order => 'created_at DESC'
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :startup_profiles
  has_many :jobs
  
  attr_accessible :name, :description
  
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
end

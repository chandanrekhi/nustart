require File.dirname(__FILE__) + '/../test_helper'

class JobTest < ActiveSupport::TestCase

  fixtures :users, :jobs
  
  test "job is NOT valid when No attributes" do
    job = Job.new
    assert !job.valid?
    assert job.errors.invalid?(:title)
    assert job.errors.invalid?(:description)
    assert job.errors.invalid?(:user)
  end
  
  test "job is valid when attributes" do
    prev_jobs_count = Job.count
    job = create_job(:user => users(:startup1))
    assert job.valid?
    assert_not_equal prev_jobs_count, Job.count
  end
  
  test "job belongs to correct startup" do 
    job = create_job(:user => users(:startup1))
    assert_equal job.startup_id, users(:startup1).id
  end
  
  private
  # creates a job with 2 attributes - title, description
  def create_job(options = {})
    Job.create({:title => "Another Dummy Job", :description => "This is just another dummy job"}.merge(options))
  end
end

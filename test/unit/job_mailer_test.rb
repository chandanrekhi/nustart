require 'test_helper'

class JobMailerTest < ActionMailer::TestCase
  test "successfully_created" do
    @expected.subject = 'JobMailer#successfully_created'
    @expected.body    = read_fixture('successfully_created')
    @expected.date    = Time.now

    assert_equal @expected.encoded, JobMailer.create_successfully_created(@expected.date).encoded
  end

  test "successfully_updated" do
    @expected.subject = 'JobMailer#successfully_updated'
    @expected.body    = read_fixture('successfully_updated')
    @expected.date    = Time.now

    assert_equal @expected.encoded, JobMailer.create_successfully_updated(@expected.date).encoded
  end

  test "jobs_expiring_in_2_days" do
    @expected.subject = 'JobMailer#jobs_expiring_in_2_days'
    @expected.body    = read_fixture('jobs_expiring_in_2_days')
    @expected.date    = Time.now

    assert_equal @expected.encoded, JobMailer.create_jobs_expiring_in_2_days(@expected.date).encoded
  end

  test "jobs_expiring_now" do
    @expected.subject = 'JobMailer#jobs_expiring_now'
    @expected.body    = read_fixture('jobs_expiring_now')
    @expected.date    = Time.now

    assert_equal @expected.encoded, JobMailer.create_jobs_expiring_now(@expected.date).encoded
  end

end

require 'test_helper'

class JobApplicationMailerTest < ActionMailer::TestCase
  test "successfully_applied" do
    @expected.subject = 'JobApplicationMailer#successfully_applied'
    @expected.body    = read_fixture('successfully_applied')
    @expected.date    = Time.now

    assert_equal @expected.encoded, JobApplicationMailer.create_successfully_applied(@expected.date).encoded
  end

  test "received_new" do
    @expected.subject = 'JobApplicationMailer#received_new'
    @expected.body    = read_fixture('received_new')
    @expected.date    = Time.now

    assert_equal @expected.encoded, JobApplicationMailer.create_received_new(@expected.date).encoded
  end

end

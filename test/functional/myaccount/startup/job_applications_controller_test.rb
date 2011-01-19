require 'test_helper'

class Myaccount::Startup::JobApplicationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:myaccount/startup_job_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create myaccount/startup_job_application" do
    assert_difference('JobApplication.count') do
      post :create, :myaccount/startup_job_application => { }
    end

    assert_redirected_to myaccount/startup_job_application_path(assigns(:myaccount/startup_job_application))
  end

  test "should show myaccount/startup_job_application" do
    get :show, :id => myaccount/startup_job_applications(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => myaccount/startup_job_applications(:one).id
    assert_response :success
  end

  test "should update myaccount/startup_job_application" do
    put :update, :id => myaccount/startup_job_applications(:one).id, :myaccount/startup_job_application => { }
    assert_redirected_to myaccount/startup_job_application_path(assigns(:myaccount/startup_job_application))
  end

  test "should destroy myaccount/startup_job_application" do
    assert_difference('JobApplication.count', -1) do
      delete :destroy, :id => myaccount/startup_job_applications(:one).id
    end

    assert_redirected_to myaccount/startup_job_applications_path
  end
end

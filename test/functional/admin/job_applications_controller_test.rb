require 'test_helper'

class Admin::JobApplicationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_job_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_job_application" do
    assert_difference('JobApplication.count') do
      post :create, :admin_job_application => { }
    end

    assert_redirected_to admin_job_application_path(assigns(:admin_job_application))
  end

  test "should show admin_job_application" do
    get :show, :id => admin_job_applications(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_job_applications(:one).id
    assert_response :success
  end

  test "should update admin_job_application" do
    put :update, :id => admin_job_applications(:one).id, :admin_job_application => { }
    assert_redirected_to admin_job_application_path(assigns(:admin_job_application))
  end

  test "should destroy admin_job_application" do
    assert_difference('JobApplication.count', -1) do
      delete :destroy, :id => admin_job_applications(:one).id
    end

    assert_redirected_to admin_job_applications_path
  end
end
